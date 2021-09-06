import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/domain/model/order/order.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';

class OrderListItem extends StatefulWidget {
  const OrderListItem({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _isExpanded = false;

  Order get _order => widget.order;

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
    final formattedCreatedDate =
        DateFormat('dd/MM/yyyy').format(_order.createdDate);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WaterText(
                'text.order_number'.tr(
                  args: [_order.id],
                ),
                fontSize: 15.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w500,
              ),
              WaterText(
                formattedCreatedDate,
                fontSize: 15.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
              ),
            ],
          ).withPadding(0.0, 2.0, 0.0, 0.0),
        ),
        const SizedBox(width: 12.0),
        GestureDetector(
          onTap: () {},
          child: Icon(
            AppIcons.close,
            size: 30.0,
            color: AppColors.secondaryText,
          ),
        )
      ],
    ).withPadding(24.0, 8.0, 18.0, 6.0);
  }

  Widget _buildContent() {
    final city = _order.city;
    final district = _order.district;
    final street = _order.street;
    final building = _order.building;
    final floor = _order.floor;
    final apartment = _order.apartment;

    String status = 'N/A';
    if (_order.status == 'Created') {
      status = 'text.order_created'.tr();
    } else if (_order.status == 'Paid') {
      status = 'text.order_paid'.tr();
    }

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
                '$city, $district, $street, $building, $floor, $apartment',
                fontSize: 12.0,
                lineHeight: 1.25,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ).withPadding(18.0, 6.0, 24.0, 0.0),
        const SizedBox(height: 12.0),
        _buildOrderProducts(),
        const SizedBox(height: 12.0),
        defaultDivider,
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WaterText(
              'text.status'.tr(),
              fontSize: 15.0,
              lineHeight: 1.25,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
            ),
            WaterText(
              status,
              fontSize: 15.0,
              lineHeight: 1.25,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
          ],
        ).withPadding(24.0, 0.0, 24.0, 0.0),
        const SizedBox(height: 6.0),
        _buildVATText(_order.products),
      ],
    );
  }

  Widget _buildOrderProducts() {
    return SeparatedColumn(
      children: [
        for (int i = 0; i < _order.products.length; i++)
          _buildOrderProduct(i, _order.products[i]),
      ],
      separator: const SizedBox(height: 6.0),
    ).withPadding(24.0, 0.0, 24.0, 0.0);
  }

  Widget _buildOrderProduct(int index, OrderProduct product) {
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
                  '${product.title} ${product.formattedVolume}',
                  fontSize: 15.0,
                  lineHeight: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: 12.0),
              WaterText(
                'x${product.amount}',
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
              (product.price * product.amount).toStringAsFixed(2),
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

  Widget _buildVATText(List<OrderProduct> products) {
    final totalPrice = products.map((product) {
      return product.price * product.amount;
    }).sum;
    final vat = totalPrice * 0.05;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.vat'.tr(),
          fontSize: 15.0,
          lineHeight: 1.25,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryText,
        ),
        WaterText(
          'text.aed'.tr(args: [
            vat.toStringAsFixed(2),
          ]),
          fontSize: 15.0,
          lineHeight: 1.25,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),
      ],
    ).withPadding(24.0, 0.0, 24.0, 0.0);
  }

  Widget _buildFooter() {
    double totalPrice = _order.products.map((product) {
      return product.price * product.amount;
    }).sum;
    totalPrice += totalPrice * 0.05;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.total'.tr(),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w600,
        ),
        WaterText(
          'text.aed'.tr(args: [
            totalPrice.toStringAsFixed(2),
          ]),
          fontSize: 18.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ],
    ).withPadding(24.0, 6.0, 24.0, 12.0);
  }
}
