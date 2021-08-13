import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

class SubscriptionListItem extends StatefulWidget {
  const SubscriptionListItem({Key? key}) : super(key: key);

  @override
  _SubscriptionListItemState createState() => _SubscriptionListItemState();
}

class _SubscriptionListItemState extends State<SubscriptionListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _isExpanded = false;

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
      child: Column(
        children: [
          _buildTitle(),
          AnimatedBuilder(
            builder: (context, child) {
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
            child: _buildContent(),
          ),
          _buildFooter(),
        ],
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  Widget _buildTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'Order #12345',
          fontSize: 15.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
        ),
        WaterText(
          'Status: Active',
          fontSize: 15.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
      ],
    ).withPadding(24.0, 10.0, 24.0, 6.0);
  }

  Widget _buildContent() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              AppIcons.pin,
              size: 32.0,
              color: AppColors.secondaryText,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: WaterText(
                'emirate, district, address, building, floor, apartment',
                fontSize: 12.0,
                lineHeight: 1.25,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ).withPadding(16.0, 0.0, 24.0, 0.0),
        const SizedBox(height: 3.0),
        Row(
          children: [
            Icon(
              AppIcons.time,
              size: 32.0,
              color: AppColors.secondaryText,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: WaterText(
                'Tuesday  1 PM - 8 AM',
                fontSize: 12.0,
                lineHeight: 1.25,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ).withPadding(16.0, 0.0, 24.0, 0.0),
        const SizedBox(height: 12.0),
        _buildOrderProducts(),
        Divider(
          height: 1.0,
          thickness: 1.0,
          color: AppColors.borderColor,
        ).withPadding(24.0, 12.0, 24.0, 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WaterText(
              'Fee',
              fontSize: 15.0,
              lineHeight: 1.25,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
            ),
            WaterText(
              'AED 0.00',
              fontSize: 15.0,
              lineHeight: 1.25,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
          ],
        ).withPadding(24.0, 0.0, 24.0, 0.0),
      ],
    );
  }

  Widget _buildOrderProducts() {
    return SeparatedColumn(
      children: [
        for (int i = 0; i < 3; i++) _buildOrderProduct(i),
      ],
      separator: const SizedBox(height: 6.0),
    ).withPadding(24.0, 0.0, 24.0, 0.0);
  }

  Widget _buildOrderProduct(int index) {
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
                  'title',
                  fontSize: 15.0,
                  lineHeight: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: 12.0),
              WaterText(
                'x2',
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
              12.toStringAsFixed(2),
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

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'Total',
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w600,
        ),
        WaterText(
          'AED 25.00',
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ],
    ).withPadding(24.0, 6.0, 24.0, 12.0);
  }
}
