import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/delivery/delivery_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/product.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/router.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/separated_column.dart';

class DeliveryPaymentScreen extends StatefulWidget {
  DeliveryPaymentScreen({Key? key}) : super(key: key);

  @override
  _DeliveryPaymentScreenState createState() => _DeliveryPaymentScreenState();
}

class _DeliveryPaymentScreenState extends State<DeliveryPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SeparatedColumn(
        children: [
          _buildBalanceText(),
          _buildSummary(),
        ],
      ),
      bottomNavigationBar: _buildBottomPanel(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'screen.payment'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          deliveryNavigator.pop();
        },
      ),
      actions: [
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBalanceText() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return WaterText(
          'text.wallet_balance'.tr(args: [state.balance.toStringAsFixed(2)]),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        );
      },
    ).withPadding(24.0, 24.0, 24.0, 12.0);
  }

  Widget _buildSummary() {
    final details = context.delivery.state as DeliveryDetailsCollected;

    return Flexible(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildDeliveryAddress(details),
            const SizedBox(height: 3.0),
            _buildDeliveryTime(details),
            const SizedBox(height: 6.0),
            _buildCartItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress(DeliveryDetailsCollected details) {
    final deliveryAddress = details.address;

    final emirate = deliveryAddress.city;
    final district = deliveryAddress.district;
    final street = deliveryAddress.street;
    final building = deliveryAddress.building;
    final floor = deliveryAddress.floor;
    final apartment = deliveryAddress.apartment;

    return Row(
      children: [
        Icon(
          AppIcons.pin,
          size: 32.0,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$emirate, $district, $street, $building, $floor, $apartment',
            fontSize: 12.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(16.0, 8.0, 24.0, 0.0);
  }

  Widget _buildDeliveryTime(DeliveryDetailsCollected details) {
    final deliveryTime = details.time;

    final locale = Localization.currentLocale(context).languageCode;
    final date = DateFormat('yyyy-MM-dd').parse(deliveryTime.date);
    final formattedDayOfWeek = DateFormat('EEEE', locale).format(date);
    final startTime = DateFormat('h').parse('${deliveryTime.period.startTime}');
    final endTime = DateFormat('h').parse('${deliveryTime.period.endTime}');
    final formattedStartTime = DateFormat('h a', locale).format(startTime);
    final formattedEndTime = DateFormat('h a', locale).format(endTime);

    return Row(
      children: [
        Icon(
          AppIcons.time,
          size: 32.0,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$formattedDayOfWeek  $formattedStartTime - $formattedEndTime',
            fontSize: 12.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(16.0, 0.0, 24.0, 0.0);
  }

  Widget _buildCartItems() {
    final items = context.cart.state.items;

    return SeparatedColumn(
      children: [
        for (int i = 0; i < items.length; i++) _buildCartItem(i, items[i]),
      ],
      separator: const SizedBox(height: 6.0),
    ).withPadding(24.0, 0.0, 24.0, 16.0);
  }

  Widget _buildCartItem(int index, CartItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 18.0,
          child: WaterText(
            '${index + 1}.',
            maxLines: 1,
            fontSize: 13.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.visible,
            color: AppColors.secondaryText,
          ),
        ),
        Flexible(
          flex: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: WaterText(
                  item.product.title.tr(),
                  fontSize: 15.0,
                  lineHeight: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: 12.0),
              WaterText(
                'x${item.amount}',
                fontSize: 15.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: WaterText(
            'text.aed'.tr(args: [
              item.totalDiscountPrice.toStringAsFixed(2),
            ]),
            fontSize: 15.0,
            lineHeight: 1.5,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
      decoration: BoxDecoration(
        border: Border(top: defaultBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDiscountPriceText(),
          const SizedBox(height: 4.0),
          _buildTotalPriceText(),
          const SizedBox(height: 20.0),
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildDiscountPriceText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.fee'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [
              0.toStringAsFixed(2),
            ]),
            fontSize: 18.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.end,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildTotalPriceText() {
    final totalPrice = context.cart.state.totalPrice;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.total'.tr(),
          fontSize: 23.0,
          lineHeight: 2.0,
        ),
        const SizedBox(width: 24.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [
              totalPrice.toStringAsFixed(2),
            ]),
            maxLines: 1,
            fontSize: 23.0,
            lineHeight: 2.0,
            textAlign: TextAlign.end,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ],
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildPayButton() {
    final balance = context.wallet.state.balance;
    final totalPrice = context.cart.state.totalPrice;

    return WaterButton(
      onPressed: () async {
        if (balance < totalPrice) {
          await _showDialog(_TopUpWalletDialog());
        } else {
          await _showDialog(_SuccessfulPaymentDialog());
          context.wallet.add(RemoveBalance(amount: totalPrice));
          context.cart.add(ClearCart());
          homeNavigator.pop();
        }
      },
      text: 'button.pay'.tr(),
    );
  }

  Future<void> _showDialog(Widget dialog) async {
    return showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
  }
}

class _SuccessfulPaymentDialog extends StatelessWidget {
  const _SuccessfulPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      title: _buildTitle(),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMessageText(),
            const SizedBox(height: 32.0),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Icon(
          AppIcons.logo,
          size: 96.0,
          color: AppColors.secondary,
        ),
        const SizedBox(height: 16.0),
        WaterText(
          'text.successful_payment'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'text.thanks_for_order'.tr(),
      fontSize: 16.0,
      lineHeight: 1.25,
      fontWeight: FontWeight.w500,
      textAlign: TextAlign.center,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: 'button.ok'.tr(),
    );
  }
}

class _TopUpWalletDialog extends StatelessWidget {
  const _TopUpWalletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      title: _buildTitle(context),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMessageText(),
            const SizedBox(height: 32.0),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PositionedDirectional(
          top: 0.0,
          end: 0.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              AppIcons.close,
              size: 32.0,
              color: AppColors.secondaryText,
            ),
            behavior: HitTestBehavior.opaque,
          ),
        ),
        Column(
          children: [
            Icon(
              AppIcons.alert,
              size: 96.0,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 16.0),
            WaterText(
              'text.top_up_wallet'.tr(),
              fontSize: 18.0,
              lineHeight: 1.5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageText() {
    return WaterText(
      'text.not_enough_money'.tr(),
      fontSize: 16.0,
      lineHeight: 1.25,
      fontWeight: FontWeight.w500,
      textAlign: TextAlign.center,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        homeNavigator.pushNamed(HomeRoutes.wallet);
        Navigator.of(context).pop();
      },
      text: 'button.top_up'.tr(),
    );
  }
}
