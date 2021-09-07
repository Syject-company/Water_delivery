import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/ui/shared_widgets/water.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildImage(),
        const SizedBox(width: 24.0),
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 80.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleText(),
                    const SizedBox(width: 12.0),
                    _buildVolumeText(),
                    const SizedBox(width: 12.0),
                    _buildRemoveItemButton(context),
                  ],
                ).withPadding(0.0, 0.0, 18.0, 0.0),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildAmountPicker(context),
                    const SizedBox(width: 12.0),
                    _buildPriceText(),
                  ],
                ).withPadding(0.0, 0.0, 24.0, 0.0),
              ],
            ),
          ),
        ),
      ],
    ).withPadding(24.0, 8.0, 0.0, 12.0);
  }

  Widget _buildImage() {
    return SizedBox(
      height: 80.0,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: cartItem.product.imageUri,
          fadeInDuration: const Duration(milliseconds: 250),
          fadeOutDuration: const Duration(milliseconds: 250),
          fadeInCurve: Curves.fastOutSlowIn,
          fadeOutCurve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return Expanded(
      child: WaterText(
        cartItem.product.title,
        maxLines: 2,
        fontSize: 15.0,
        lineHeight: 1.5,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ).withPadding(0.0, 2.0, 0.0, 0.0),
    );
  }

  Widget _buildVolumeText() {
    return WaterText(
      cartItem.product.formattedVolume,
      maxLines: 1,
      fontSize: 15.0,
      lineHeight: 1.5,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
      overflow: TextOverflow.ellipsis,
    ).withPadding(0.0, 2.0, 0.0, 0.0);
  }

  Widget _buildRemoveItemButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.cart.add(
          RemoveFromCart(product: cartItem.product),
        );
      },
      child: Icon(
        AppIcons.close,
        size: 30.0,
        color: AppColors.secondaryText,
      ),
    );
  }

  Widget _buildAmountPicker(BuildContext context) {
    return WaterNumberPicker(
      value: cartItem.amount,
      onChanged: (value) {
        context.cart.add(
          AddToCart(
            product: cartItem.product,
            amount: value,
          ),
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
    final discount = cartItem.product.discount;

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (discount > 0.0)
            WaterText(
              'text.aed'.tr(args: [
                cartItem.totalPrice.toStringAsFixed(2),
              ]),
              maxLines: 1,
              fontSize: 15.0,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
              overflow: TextOverflow.ellipsis,
              decoration: TextDecoration.lineThrough,
            ).withPadding(0.0, 0.0, 0.0, 3.0),
          WaterText(
            'text.aed'.tr(args: [
              cartItem.totalDiscountPrice.toStringAsFixed(2),
            ]),
            maxLines: 1,
            fontSize: 19.0,
            lineHeight: 1.5,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
