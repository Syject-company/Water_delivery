import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/checkout/payment/payment_bloc.dart';
import 'package:water/bloc/home/checkout/subscription/subscription_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart' as navigation;
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/promo_codes/promo_codes_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/domain/model/promo_code/promo_code.dart';
import 'package:water/ui/screens/home/checkout/subscription/subscription_navigator.dart';
import 'package:water/ui/screens/home/checkout/widgets/promo_code_input.dart';
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
        if (state is TopUpWallet) {
          await showWaterDialog(context, TopUpWalletAlert());
        } else if (state is SuccessfulPayment) {
          await showWaterDialog(context, SuccessfulPaymentAlert());
          context.navigation.add(
            navigation.NavigateTo(screen: navigation.Screen.home),
          );
          context.navigation.add(
            navigation.BackPressed(),
          );
          homeNavigator.pop();
        } else if (state is PaymentError) {
          await showWaterDialog(context, ErrorAlert());
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
        AppBarWhatsappButton(),
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
            defaultDivider,
            PromoCodeInput(),
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
          size: 36.0,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$emirate, $district, $street, $building, $floor, $apartment',
            fontSize: 16.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w600,
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
          size: 36.0,
          color: AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$formattedDayOfWeek  $formattedStartTime - $formattedEndTime',
            fontSize: 16.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w600,
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
          size: 30.0,
          color: AppColors.secondaryText,
        ).withPaddingAll(3),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            'text.months'.plural(months),
            fontSize: 16.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w600,
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
            fontSize: 14.0,
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
                  fontSize: 16.0,
                  lineHeight: 1.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: 12.0),
              WaterText(
                'x${item.amount}',
                fontSize: 16.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryText,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: WaterText(
            'text.aed'.tr(args: [
              item.totalDiscountPrice.toStringAsFixed(2),
            ]),
            fontSize: 16.0,
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
          _buildVATText(details),
          const SizedBox(height: 4.0),
          _buildMonthlyPaymentText(details),
          const SizedBox(height: 4.0),
          _buildTotalPriceText(details),
          const SizedBox(height: 20.0),
          _buildPayButton(context, details),
        ],
      ),
    );
  }

  Widget _buildVATText(SubscriptionDetailsCollected details) {
    return BlocBuilder<PromoCodesBloc, PromoCodesState>(
      builder: (context, state) {
        PromoCode? promoCode;
        if (state is PromoCodeLoaded) {
          promoCode = state.promoCode;
        }
        double vat = context.cart.state.vat * (details.months * 4);
        vat *= (1.0 - (promoCode?.discount ?? 0.0));
        vat -= (promoCode?.discountAmount ?? 0.0);

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
        );
      },
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildMonthlyPaymentText(SubscriptionDetailsCollected details) {
    return BlocBuilder<PromoCodesBloc, PromoCodesState>(
      builder: (context, state) {
        PromoCode? promoCode;
        if (state is PromoCodeLoaded) {
          promoCode = state.promoCode;
        }
        double monthlyPayment = context.cart.state.totalPrice * 4;
        monthlyPayment *= (1.0 - (promoCode?.discount ?? 0.0));
        monthlyPayment -= (promoCode?.discountAmount ?? 0.0);

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
        );
      },
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildTotalPriceText(SubscriptionDetailsCollected details) {
    return BlocBuilder<PromoCodesBloc, PromoCodesState>(
      builder: (context, state) {
        PromoCode? promoCode;
        if (state is PromoCodeLoaded) {
          promoCode = state.promoCode;
        }
        double totalPrice = context.cart.state.totalPrice;
        totalPrice *= (1.0 - (promoCode?.discount ?? 0.0));
        totalPrice -= (promoCode?.discountAmount ?? 0.0);

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
        );
      },
    ).withPadding(12.0, 0.0, 12.0, 0.0);
  }

  Widget _buildPayButton(
    BuildContext context,
    SubscriptionDetailsCollected details,
  ) {
    return WaterButton(
      onPressed: () async {
        final paymentState = context.payment.state;

        if (paymentState is SubscriptionPaymentRequest) {
          return;
        }

        final subscriptionState = context.subscription.state;
        final promoCodesState = context.promoCodes.state;

        if (subscriptionState is SubscriptionDetailsCollected) {
          final time = subscriptionState.time;
          final items = context.cart.state.items;
          final address = subscriptionState.address;

          String? promoCode;
          if (promoCodesState is PromoCodeLoaded) {
            promoCode = promoCodesState.promoCode.code;
          }

          context.payment.add(
            PayForSubscription(
              time: time,
              items: items,
              address: address,
              months: details.months,
              promoCode: promoCode,
            ),
          );
        }
      },
      text: 'button.pay'.tr(),
    );
  }
}
