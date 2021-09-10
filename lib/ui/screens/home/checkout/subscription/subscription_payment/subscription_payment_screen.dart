import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/checkout/payment/payment_bloc.dart';
import 'package:water/bloc/home/checkout/subscription/subscription_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart' as navigation;
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/ui/screens/home/checkout/subscription/subscription_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/separated_column.dart';

class SubscriptionPaymentScreen extends StatelessWidget {
  SubscriptionPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        if (state is TopUpWalletAlert) {
          await _showDialog(context, TopUpWalletDialog());
        } else if (state is SuccessfulPaymentAlert) {
          await _showDialog(context, SuccessfulPaymentDialog());
          context.navigation.add(
            navigation.NavigateTo(screen: navigation.Screen.home),
          );
          context.navigation.add(
            navigation.BackPressed(),
          );
          homeNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
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
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          subscriptionNavigator.pop();
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

  Widget _buildBody(BuildContext context) {
    return LoaderOverlay(
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          context.showLoader(state is SubscriptionPaymentRequest);
        },
        child: Column(
          children: [
            _buildBalanceText(context),
            defaultDivider,
            _buildSummary(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceText(BuildContext context) {
    final balance = context.profile.state.walletBalance;

    return WaterText(
      'text.wallet_balance'.tr(args: [
        balance.toStringAsFixed(2),
      ]),
      fontSize: 18.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    ).withPaddingAll(24.0);
  }

  Widget _buildSummary(BuildContext context) {
    final details = context.subscription.state as SubscriptionDetailsCollected;

    return Flexible(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildDeliveryAddress(details),
            _buildDeliveryTime(context, details),
            _buildSubscriptionDuration(context, details),
            _buildCartItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddress(SubscriptionDetailsCollected details) {
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
            fontSize: 13.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(18.0, 18.0, 24.0, 0.0);
  }

  Widget _buildDeliveryTime(
    BuildContext context,
    SubscriptionDetailsCollected details,
  ) {
    final deliveryTime = details.time;
    final locale = Localization.currentLocale(context).languageCode;
    final formattedDayOfWeek =
        DateFormat('EEEE', locale).format(deliveryTime.date);
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
            fontSize: 13.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(18.0, 0.0, 24.0, 0.0);
  }

  Widget _buildSubscriptionDuration(
    BuildContext context,
    SubscriptionDetailsCollected details,
  ) {
    final months = details.months;

    return Row(
      children: [
        Icon(
          Icons.update,
          size: 26.0,
          color: AppColors.secondaryText,
        ).withPaddingAll(3),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            'text.months'.plural(months),
            fontSize: 13.0,
            lineHeight: 1.25,
            fontWeight: FontWeight.w500,
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

  Widget _buildCartItem(
    int index,
    CartItem item,
  ) {
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
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.w600,
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
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: 12.0),
              WaterText(
                'x${item.amount}',
                fontSize: 15.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w600,
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
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    final details = context.subscription.state as SubscriptionDetailsCollected;

    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
      decoration: BoxDecoration(
        border: Border(top: defaultBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildVATText(context, details),
          const SizedBox(height: 4.0),
          _buildMonthlyPaymentText(context, details),
          const SizedBox(height: 4.0),
          _buildTotalPriceText(context, details),
          const SizedBox(height: 20.0),
          _buildPayButton(context, details),
        ],
      ),
    );
  }

  Widget _buildVATText(
    BuildContext context,
    SubscriptionDetailsCollected details,
  ) {
    final vat = context.cart.state.vat * (details.months * 4);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.vat'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
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
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildMonthlyPaymentText(
    BuildContext context,
    SubscriptionDetailsCollected details,
  ) {
    final monthlyPayment = context.cart.state.totalPrice * 4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.monthly'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: WaterText(
            'text.aed'.tr(args: [
              monthlyPayment.toStringAsFixed(2),
            ]),
            fontSize: 18.0,
            lineHeight: 1.5,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildTotalPriceText(
    BuildContext context,
    SubscriptionDetailsCollected details,
  ) {
    final totalPrice = context.cart.state.totalPrice * (details.months * 4);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.total'.tr(),
          fontSize: 23.0,
          lineHeight: 2.0,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
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
            fontWeight: FontWeight.w800,
            color: AppColors.primaryText,
          ),
        ),
      ],
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildPayButton(
    BuildContext context,
    SubscriptionDetailsCollected details,
  ) {
    return WaterButton(
      onPressed: () async {
        final subscriptionState = context.subscription.state;

        if (subscriptionState is SubscriptionDetailsCollected) {
          final time = subscriptionState.time;
          final items = context.cart.state.items;
          final address = subscriptionState.address;

          context.payment.add(
            PayForSubscription(
              time: time,
              items: items,
              address: address,
              months: details.months,
            ),
          );
        }
      },
      text: 'button.pay'.tr(),
    );
  }

  Future<void> _showDialog(
    BuildContext context,
    Widget dialog,
  ) async {
    return showDialog(
      context: context,
      builder: (_) => dialog,
      barrierDismissible: false,
    );
  }
}
