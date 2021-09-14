import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/checkout/order/order_bloc.dart';
import 'package:water/bloc/home/checkout/payment/payment_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart' as navigation;
import 'package:water/bloc/home/promo_codes/promo_codes_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/domain/model/promo_code/promo_code.dart';
import 'package:water/ui/screens/home/checkout/order/order_navigator.dart';
import 'package:water/ui/screens/home/checkout/widgets/promo_code_input.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/separated_column.dart';
import 'package:water/util/slide_with_fade_page_route.dart';

import 'order_payment_view/order_payment_view_screen.dart';

class OrderPaymentScreen extends StatelessWidget {
  OrderPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (_, state) async {
        if (state is OrderPaymentView) {
          final successfulPayment = await orderNavigator.push<bool>(
            SlideWithFadePageRoute(
              builder: (_) => OrderPaymentViewScreen(url: state.url),
            ),
          );

          if (successfulPayment != null && successfulPayment) {
            context.payment.add(
              FinishPayment(),
            );
          }
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

  Widget _buildBody(BuildContext context) {
    return LoaderOverlay(
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          context.showLoader(state is OrderPaymentRequest);
        },
        child: Column(
          children: [
            defaultDivider,
            _buildSummary(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    final details = context.order.state as OrderDetailsCollected;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildDeliveryAddress(details),
          _buildDeliveryTime(context, details),
          _buildCartItems(context),
          defaultDivider,
          PromoCodeInput(),
        ],
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
    OrderDetailsCollected details,
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
    ).withPadding(18.0, 0.0, 24.0, 12.0);
  }

  Widget _buildCartItems(BuildContext context) {
    final items = context.cart.state.items;

    return SeparatedColumn(
      children: [
        for (int i = 0; i < items.length; i++) _buildCartItem(i, items[i]),
      ],
      separator: const SizedBox(height: 12.0),
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
    return BlocBuilder<PromoCodesBloc, PromoCodesState>(
      builder: (_, state) {
        PromoCode? promoCode;
        if (state is PromoCodeLoaded) {
          promoCode = state.promoCode;
        }
        double vat = context.cart.state.vat;
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

  Widget _buildTotalPriceText(BuildContext context) {
    return BlocBuilder<PromoCodesBloc, PromoCodesState>(
      builder: (_, state) {
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

  Widget _buildPayButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        final paymentState = context.payment.state;

        if (paymentState is OrderPaymentRequest) {
          return;
        }

        final orderState = context.order.state;
        final promoCodesState = context.promoCodes.state;

        if (orderState is OrderDetailsCollected) {
          final time = orderState.time;
          final items = context.cart.state.items;
          final address = orderState.address;

          String? promoCode;
          if (promoCodesState is PromoCodeLoaded) {
            promoCode = promoCodesState.promoCode.code;
          }

          context.payment.add(
            PayForOrder(
              time: time,
              items: items,
              address: address,
              promoCode: promoCode,
            ),
          );
        }
      },
      text: 'button.pay'.tr(),
    );
  }
}
