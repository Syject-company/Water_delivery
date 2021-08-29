import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/checkout/order/order_bloc.dart';
import 'package:water/bloc/home/checkout/payment/payment_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/order/order_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/separated_column.dart';

class OrderPaymentScreen extends StatelessWidget {
  OrderPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        if (state is TopUpWallet) {
          await _showDialog(context, TopUpWalletDialog());
        } else if (state is SuccessfulPayment) {
          await _showDialog(context, SuccessfulPaymentDialog());
          homeNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SeparatedColumn(
          children: [
            _buildBalanceText(),
            _buildSummary(context),
          ],
        ),
        bottomNavigationBar: _buildBottomPanel(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      title: WaterText(
        'screen.payment'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          orderNavigator.pop();
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
          'text.wallet_balance'.tr(args: [
            state.balance.toStringAsFixed(2),
          ]),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        );
      },
    ).withPaddingAll(24.0);
  }

  Widget _buildSummary(BuildContext context) {
    final details = context.order.state as OrderDetailsCollected;

    return Flexible(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildDeliveryAddress(details),
            _buildDeliveryTime(context, details),
            _buildCartItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress(OrderDetailsCollected details) {
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
    ).withPadding(18.0, 18.0, 24.0, 0.0);
  }

  Widget _buildDeliveryTime(
    BuildContext context,
    OrderDetailsCollected details,
  ) {
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
    ).withPadding(18.0, 0.0, 24.0, 12.0);
  }

  Widget _buildCartItems(BuildContext context) {
    final items = context.cart.state.items;

    return SeparatedColumn(
      children: [
        for (int i = 0; i < items.length; i++) _buildCartItem(i, items[i]),
      ],
      separator: const SizedBox(height: 6.0),
    ).withPadding(24.0, 0.0, 24.0, 24.0);
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
                  '${item.product.title} ${item.product.formattedVolume}',
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

  Widget _buildBottomPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
      decoration: BoxDecoration(
        border: Border(top: defaultBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildVATPriceText(context),
          const SizedBox(height: 4.0),
          _buildTotalPriceText(context),
          const SizedBox(height: 20.0),
          _buildPayButton(context),
        ],
      ),
    );
  }

  Widget _buildVATPriceText(BuildContext context) {
    final vat = context.cart.state.vat;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.vat'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [
              vat.toStringAsFixed(2),
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

  Widget _buildTotalPriceText(BuildContext context) {
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

  Widget _buildPayButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        context.payment.add(PayForOrder());
      },
      text: 'button.pay'.tr(),
    );
  }

  Future<void> _showDialog(BuildContext context, Widget dialog) async {
    return showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
  }
}
