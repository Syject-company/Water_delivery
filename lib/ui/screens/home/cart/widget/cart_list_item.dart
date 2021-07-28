import 'package:flutter/material.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/number_picker.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class CartListItem extends StatefulWidget {
  const CartListItem(
    this.item, {
    Key? key,
  }) : super(key: key);

  final CartItem item;

  @override
  _CartListItemState createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  CartItem get _item => widget.item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 80.0,
            child: _buildImage(),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 80.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(child: _buildTitleText()),
                            const SizedBox(width: 12.0),
                            _buildVolumeText(),
                            const SizedBox(width: 12.0),
                            _buildRemoveItemButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildAmountPicker(),
                      const SizedBox(width: 12.0),
                      Flexible(child: _buildPriceText()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Image.asset(_item.product.imageUri),
    );
  }

  Widget _buildTitleText() {
    return WaterText(
      _item.product.title,
      maxLines: 2,
      lineHeight: 1.5,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildVolumeText() {
    return WaterText(
      '${_item.product.volume} LT',
      maxLines: 1,
      lineHeight: 1.5,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryText,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRemoveItemButton() {
    return GestureDetector(
      onTap: () {
        context.cart.add(
          RemoveFromCart(product: _item.product),
        );
      },
      child: Icon(
        Icons.close,
        size: 30.0,
        color: AppColors.secondaryText,
      ),
    );
  }

  Widget _buildAmountPicker() {
    return WaterNumberPicker(
      value: _item.amount,
      onChanged: (value) {
        context.cart.add(
          AddToCart(product: _item.product, amount: value),
        );
      },
      minValue: 1,
      maxWidth: 120.0,
      showBorder: false,
      dynamicColor: false,
      size: PickerSize.small,
      alignment: AlignmentDirectional.centerStart,
    );
  }

  Widget _buildPriceText() {
    final sale = _item.product.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final totalPrice = _item.product.price * _item.amount;
    final totalDiscountPrice = totalPrice - (totalPrice * discount);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (discount > 0.0)
          Column(
            children: <Widget>[
              WaterText(
                '\$${totalPrice.toStringAsFixed(2)}',
                maxLines: 1,
                lineHeight: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
                overflow: TextOverflow.ellipsis,
                decoration: TextDecoration.lineThrough,
              ),
              const SizedBox(height: 3.0),
            ],
          ),
        WaterText(
          '\$${totalDiscountPrice.toStringAsFixed(2)}',
          maxLines: 1,
          fontSize: 19.0,
          lineHeight: 1.5,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }
}
