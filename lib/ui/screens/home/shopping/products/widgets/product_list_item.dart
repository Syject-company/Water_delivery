import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/domain/model/shopping/product.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/shopping/product/product_screen.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/fade_page_route.dart';

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
  Product get _product => widget.product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: GestureDetector(
        onTap: () {
          homeNavigator.push(
            FadePageRoute(
              builder: (context) {
                return ProductScreen(product: _product);
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.0),
            border: Border.fromBorderSide(defaultBorder),
          ),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: _product,
                  child: CachedNetworkImage(
                    imageUrl: _product.imageUri,
                    fadeInCurve: Curves.fastOutSlowIn,
                    fadeOutCurve: Curves.fastOutSlowIn,
                  ),
                ).withPadding(4.0, 4.0, 4.0, 0.0),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceText(),
                    const SizedBox(height: 2.0),
                    _buildTitleText(),
                    const SizedBox(height: 2.0),
                    _buildVolumeText(),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return !context.cart.contains(_product)
                      ? _buildAddToCartButton()
                      : _buildAmountPicker();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceText() {
    final price = _product.price;
    final discountPrice = _product.discountPrice;
    final discount = _product.discount;

    return Row(
      children: [
        WaterText(
          'text.aed'.tr(args: [
            price.toStringAsFixed(2),
          ]),
          maxLines: 1,
          fontSize: 19.0,
          lineHeight: 1.5,
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w800,
          color: AppColors.primaryText,
          softWrap: false,
        ),
        if (discount > 0.0)
          Flexible(
            child: Row(
              children: [
                const SizedBox(width: 6.0),
                Flexible(
                  child: WaterText(
                    discountPrice.toStringAsFixed(2),
                    maxLines: 1,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.fade,
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.secondaryText,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTitleText() {
    final title = _product.title;

    return Flexible(
      child: WaterText(
        title,
        maxLines: 2,
        fontSize: 15.0,
        lineHeight: 1.5,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
      ),
    );
  }

  Widget _buildVolumeText() {
    final volume = _product.formattedVolume;

    return WaterText(
      volume,
      maxLines: 1,
      fontSize: 15.0,
      lineHeight: 1.5,
      fontWeight: FontWeight.w700,
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
          _showToast('toast.product_added'.tr());
        },
        icon: AppIcons.plus,
      ),
    );
  }

  Widget _buildAmountPicker() {
    final item = context.cart.findItem(_product.id);

    return WaterNumberPicker(
      value: item?.amount ?? 0,
      onChanged: (value) {
        if (value == 0) {
          context.cart.add(
            RemoveFromCart(product: _product),
          );
          _showToast('toast.product_removed'.tr());
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
        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.fromBorderSide(defaultBorder),
          borderRadius: BorderRadius.circular(19.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.15),
              spreadRadius: 0.0,
              blurRadius: 6.0,
              offset: const Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          textDirection: Directionality.of(context),
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: CachedNetworkImage(
                fadeInCurve: Curves.fastOutSlowIn,
                fadeOutCurve: Curves.fastOutSlowIn,
                imageUrl: _product.imageUri,
              ),
            ),
            const SizedBox(width: 24.0),
            Expanded(
              child: WaterText(
                message,
                fontSize: 18.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
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
