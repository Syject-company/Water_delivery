import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/subscriptions/subscriptions_bloc.dart';
import 'package:water/domain/model/subscription/subscription.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/localization.dart';

class SubscriptionListItem extends StatefulWidget {
  const SubscriptionListItem({
    Key? key,
    required this.subscription,
    this.selected = false,
  }) : super(key: key);

  final Subscription subscription;
  final bool selected;

  @override
  SubscriptionListItemState createState() => SubscriptionListItemState();
}

class SubscriptionListItemState extends State<SubscriptionListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _isExpanded = false;

  Subscription get _subscription => widget.subscription;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (_isExpanded = !_isExpanded)
            ? _animationController.forward()
            : _animationController.reverse();
      },
      onLongPress: () {
        setState(() {
          if (widget.selected) {
            context.subscriptions.add(
              DeselectSubscription(),
            );
          } else {
            context.subscriptions.add(
              SelectSubscription(subscription: _subscription),
            );
          }
        });
      },
      child: Container(
        color: widget.selected ? AppColors.primary : AppColors.white,
        child: Column(
          children: [
            _buildTitle(),
            _buildContent(),
            _buildFooter(),
          ],
        ),
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildTitle() {
    final subscriptionStatus = _subscription.isActive
        ? 'text.subscription_active'
        : 'text.subscription_stopped';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.order_number'.tr(
            args: ['${_subscription.id}'],
          ),
          fontSize: 16.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
          color: widget.selected ? AppColors.white : AppColors.primaryText,
        ),
        WaterText(
          '${'text.status'.tr()}: ${subscriptionStatus.tr()}',
          fontSize: 16.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
          color: widget.selected ? AppColors.white : AppColors.secondaryText,
        ),
      ],
    ).withPadding(24.0, 12.0, 24.0, 6.0);
  }

  Widget _buildContent() {
    return AnimatedBuilder(
      builder: (_, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOutCubic,
            ),
          ),
          child: SizeTransition(
            axisAlignment: -1.0,
            sizeFactor: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOutCubic,
              ),
            ),
            child: child!,
          ),
        );
      },
      animation: _animationController,
      child: Column(
        children: [
          _buildDeliveryAddress(),
          _buildDeliveryDate(),
          _buildExpireDate(),
          const SizedBox(height: 12.0),
          _buildSubscriptionsProducts(),
          const SizedBox(height: 12.0),
          defaultDivider.withPadding(24.0, 0.0, 24.0, 0.0),
          const SizedBox(height: 12.0),
          _buildVATText(),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    final city = _subscription.city;
    final district = _subscription.district;
    final street = _subscription.street;
    final building = _subscription.building;
    final floor = _subscription.floor;
    final apartment = _subscription.apartment;

    return Row(
      children: [
        Icon(
          AppIcons.pin,
          size: 36.0,
          color: widget.selected ? AppColors.white : AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$city, $district, $street, $building, $floor, $apartment',
            fontSize: 16.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w600,
            color: widget.selected ? AppColors.white : AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(18.0, 6.0, 24.0, 0.0);
  }

  Widget _buildDeliveryDate() {
    final deliveryTime = _subscription.time;
    final locale = Localization.currentLocale(context).languageCode;
    final formattedDayOfWeek =
        DateFormat('EEEE', locale).format(_subscription.deliveryDate);
    final startTime = DateFormat('h').parse('${deliveryTime.startTime}');
    final endTime = DateFormat('h').parse('${deliveryTime.endTime}');
    final formattedStartTime = DateFormat('h a', locale).format(startTime);
    final formattedEndTime = DateFormat('h a', locale).format(endTime);

    return Row(
      children: [
        Icon(
          AppIcons.time,
          size: 36.0,
          color: widget.selected ? AppColors.white : AppColors.secondaryText,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            '$formattedDayOfWeek  $formattedStartTime - $formattedEndTime',
            fontSize: 16.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w600,
            color: widget.selected ? AppColors.white : AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(18.0, 0.0, 24.0, 0.0);
  }

  Widget _buildExpireDate() {
    final expireDate = DateFormat.yMMMMd().format(_subscription.expireDate);

    return Row(
      children: [
        Icon(
          AppIcons.duration,
          size: 28.0,
          color: widget.selected ? AppColors.white : AppColors.secondaryText,
        ).withPaddingAll(4),
        const SizedBox(width: 12.0),
        Expanded(
          child: WaterText(
            'text.expires_on'.tr(args: [
              expireDate,
            ]),
            fontSize: 16.0,
            lineHeight: 1.5,
            fontWeight: FontWeight.w600,
            color: widget.selected ? AppColors.white : AppColors.secondaryText,
          ),
        ),
      ],
    ).withPadding(18.0, 0.0, 24.0, 0.0);
  }

  Widget _buildSubscriptionsProducts() {
    return SeparatedColumn(
      children: [
        for (int i = 0; i < _subscription.products.length; i++)
          _buildSubscriptionProduct(i, _subscription.products[i]),
      ],
      separator: const SizedBox(height: 12.0),
    ).withPadding(24.0, 0.0, 24.0, 0.0);
  }

  Widget _buildSubscriptionProduct(
    int index,
    SubscriptionProduct product,
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
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
            color: widget.selected ? AppColors.white : AppColors.secondaryText,
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
                  '${product.title} ${product.formattedVolume}',
                  fontSize: 16.0,
                  lineHeight: 1.5,
                  fontWeight: FontWeight.w600,
                  color: widget.selected
                      ? AppColors.white
                      : AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: 12.0),
              WaterText(
                'x${product.amount}',
                fontSize: 16.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w600,
                color:
                    widget.selected ? AppColors.white : AppColors.secondaryText,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: WaterText(
            'text.aed'.tr(args: [
              (product.price * product.amount).toStringAsFixed(2),
            ]),
            fontSize: 16.0,
            lineHeight: 1.5,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.w700,
            color: widget.selected ? AppColors.white : AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildVATText() {
    final totalPrice = _subscription.products.map((product) {
      return product.price * product.amount;
    }).sum;
    final vat = totalPrice * 0.05;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.vat'.tr(),
          fontSize: 16.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
          color: widget.selected ? AppColors.white : AppColors.secondaryText,
        ),
        WaterText(
          'text.aed'.tr(args: [
            vat.toStringAsFixed(2),
          ]),
          fontSize: 16.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
          color: widget.selected ? AppColors.white : AppColors.primaryText,
        ),
      ],
    ).withPadding(24.0, 0.0, 24.0, 0.0);
  }

  Widget _buildFooter() {
    double totalPrice = _subscription.products.map((product) {
      return product.price * product.amount;
    }).sum;
    totalPrice += totalPrice * 0.05;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.total'.tr(),
          fontSize: 19.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w700,
          color: widget.selected ? AppColors.white : AppColors.primaryText,
        ),
        WaterText(
          'text.aed'.tr(args: [
            totalPrice.toStringAsFixed(2),
          ]),
          fontSize: 19.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w800,
          color: widget.selected ? AppColors.white : AppColors.primaryText,
        ),
      ],
    ).withPadding(24.0, 6.0, 24.0, 12.0);
  }
}
