import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/domain/model/home/shop/product.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/shop/product/product_screen.dart';
import 'package:water/ui/shared_widgets/button/icon_button.dart';
import 'package:water/ui/shared_widgets/number_picker.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/ui/shared_widgets/toast.dart';
import 'package:water/util/slide_with_fade_route.dart';

class ProductListItem extends StatefulWidget {
  const ProductListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  // late bool _addedToCart = context.cart.getItemById(widget.product.id) != null;

  Product get _product => widget.product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            SlideWithFadeRoute(
              builder: (_) => BlocProvider.value(
                value: context.cart,
                child: ProductScreen(product: _product),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.0),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            children: <Widget>[
              Expanded(child: Image.asset(_product.imageUri)),
              const SizedBox(height: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildPriceText(),
                    const SizedBox(height: 2.0),
                    Flexible(child: _buildTitleText()),
                    const SizedBox(height: 2.0),
                    _buildCapacityText(),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              BlocBuilder<CartBloc, CartState>(
                builder: (_, state) {
                  return context.cart.contains(_product)
                      ? _buildAmountPicker()
                      : _buildAddToCartButton();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceText() {
    final sale = _product.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final price = _product.price;
    final discountPrice = price - (price * discount);

    return Row(
      children: <Widget>[
        WaterText(
          '\$${discountPrice.toStringAsFixed(2)}',
          maxLines: 1,
          fontSize: 19.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
        if (discount > 0.0)
          Row(
            children: <Widget>[
              const SizedBox(width: 12.0),
              WaterText(
                '\$${price.toStringAsFixed(2)}',
                maxLines: 1,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
                decoration: TextDecoration.lineThrough,
                color: AppColors.secondaryText,
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildTitleText() {
    return WaterText(
      _product.title,
      maxLines: 2,
      fontSize: 15.0,
      lineHeight: 1.5,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCapacityText() {
    return WaterText(
      '${_product.volume} LT',
      maxLines: 1,
      fontSize: 15.0,
      lineHeight: 1.5,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildAddToCartButton() {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: WaterIconButton(
        onPressed: () {
          context.cart.add(
            AddToCart(product: _product, amount: 1),
          );
          _showToast('Product has been added to the cart!');
        },
        icon: AppIcons.plus,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primaryText,
      ),
    );
  }

  Widget _buildAmountPicker() {
    final item = context.cart.getItemById(_product.id);

    return WaterNumberPicker(
      value: item?.amount ?? 0,
      onChanged: (value) {
        if (value == 0) {
          context.cart.add(
            RemoveFromCart(product: _product),
          );
          _showToast('Product has been removed from the cart!');
        } else {
          context.cart.add(
            AddToCart(product: _product, amount: value),
          );
        }
      },
      showBorder: false,
    );
  }

  void _showToast(String message) {
    return ToastBuilder.of(context).showToast(
      child: Container(
        height: 96.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(19.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.25),
              spreadRadius: 0.0,
              blurRadius: 10.0,
              offset: const Offset(0.0, 4.0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          textDirection: Directionality.of(context),
          children: <Widget>[
            AspectRatio(
                aspectRatio: 1.0, child: Image.asset(_product.imageUri)),
            const SizedBox(width: 24.0),
            Expanded(
              child: WaterText(
                message,
                fontSize: 16.0,
                textAlign: TextAlign.center,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 2),
    );
  }
}
