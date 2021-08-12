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
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/router.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/separated_column.dart';

import '../delivery_navigator.dart';

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
      body: Column(
        children: <Widget>[
          _buildBalanceText(),
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: AppColors.borderColor,
          ),
          Flexible(child: _buildSummary()),
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
        onPressed: () => deliveryNavigator.pop(),
      ),
      actions: <Widget>[
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
        return Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
          child: WaterText(
            'text.wallet_balance'.tr(args: [state.balance.toStringAsFixed(2)]),
            fontSize: 18.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _buildSummary() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          _buildDeliveryAddress(),
          const SizedBox(height: 6.0),
          _buildDeliveryTime(),
          const SizedBox(height: 6.0),
          _buildCartItems(),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    final deliveryAddress = context.delivery.state.address!;
    final emirate = deliveryAddress.city;
    final district = deliveryAddress.district;
    final address = deliveryAddress.address;
    final building = deliveryAddress.building;
    final floor = deliveryAddress.floor;
    final apartment = deliveryAddress.apartment;

    return Row(
      children: <Widget>[
        Icon(
          AppIcons.pin,
          size: 32.0,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$emirate, $district, $address, $building, $floor, $apartment',
            fontSize: 12.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryTime() {
    final deliveryTime = context.delivery.state.time!;

    final locale = Localization.currentLocale(context).languageCode;
    final date = DateFormat('yyyy-MM-dd').parse(deliveryTime.date);
    final formattedDayOfWeek = DateFormat('EEEE', locale).format(date);
    final startTime = DateFormat('h').parse('${deliveryTime.period.startTime}');
    final endTime = DateFormat('h').parse('${deliveryTime.period.endTime}');
    final formattedStartTime = DateFormat('h a', locale).format(startTime);
    final formattedEndTime = DateFormat('h a', locale).format(endTime);

    return Row(
      children: <Widget>[
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
    );
  }

  Widget _buildCartItems() {
    final items = context.cart.state.items;

    return SeparatedColumn(
      children: <Widget>[
        for (int i = 0; i < items.length; i++) _buildCartItem(i, items[i]),
      ],
      separator: const SizedBox(height: 6.0),
    );
  }

  Widget _buildCartItem(int index, CartItem item) {
    final title = item.product.title.tr();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            children: <Widget>[
              Flexible(
                child: WaterText(
                  '$title',
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
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.borderColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
              'text.aed'.tr(args: [0.toStringAsFixed(2)]),
              fontSize: 18.0,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceText() {
    final totalPrice = context.cart.state.totalPrice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          WaterText(
            'text.total'.tr(),
            fontSize: 23.0,
            lineHeight: 2.0,
          ),
          const SizedBox(width: 24.0),
          Flexible(
            child: WaterText(
              'text.aed'.tr(args: [totalPrice.toStringAsFixed(2)]),
              maxLines: 1,
              fontSize: 23.0,
              lineHeight: 2.0,
              textAlign: TextAlign.end,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
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
          children: <Widget>[
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
      children: <Widget>[
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
          children: <Widget>[
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
      children: <Widget>[
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
          children: <Widget>[
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
