import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/domain/model/shopping/product.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late int amount = context.cart.findItem(_product.id)?.amount ?? 0;

  Product get _product => widget.product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildCheckoutPanel(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
        },
      ),
      actions: [
        AppBarIconButton(
          icon: AppIcons.whatsapp,
          onPressed: () {},
        ),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (_, constraints) {
                return Hero(
                  tag: _product,
                  child: CachedNetworkImage(
                    height: isMobile
                        ? constraints.maxWidth / 1.25
                        : constraints.maxWidth / 2.0,
                    fadeInCurve: Curves.fastOutSlowIn,
                    fadeOutCurve: Curves.fastOutSlowIn,
                    imageUrl: _product.imageUri,
                  ),
                );
              },
            ).withPadding(isMobile ? 0.0 : 48.0, 0.0, isMobile ? 0.0 : 48.0, 0.0),
            const SizedBox(height: 24.0),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTitleText(),
                    const SizedBox(width: 16.0),
                    _buildVolumeText(),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPriceText(),
                    const SizedBox(width: 16.0),
                    _buildAmountPicker(),
                  ],
                ),
                const SizedBox(height: 16.0),
                _buildDescriptionText(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return Flexible(
      child: WaterText(
        _product.title,
        fontSize: 24.0,
        lineHeight: 2.0,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
      ),
    );
  }

  Widget _buildVolumeText() {
    return WaterText(
      _product.formattedVolume,
      fontSize: 22.0,
      lineHeight: 2.0,
      fontWeight: FontWeight.w700,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildPriceText() {
    final discount = _product.discount;

    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (discount > 0.0)
            WaterText(
              'text.aed'.tr(args: [
                _product.price.toStringAsFixed(2),
              ]),
              maxLines: 1,
              fontSize: 18.0,
              lineHeight: 1.5,
              overflow: TextOverflow.fade,
              fontWeight: FontWeight.w700,
              color: AppColors.secondaryText,
              decoration: TextDecoration.lineThrough,
              softWrap: false,
            ).withPadding(0.0, 0.0, 0.0, 6.0),
          WaterText(
            'text.aed'.tr(args: [
              _product.discountPrice.toStringAsFixed(2),
            ]),
            maxLines: 1,
            fontSize: 27.0,
            lineHeight: 2,
            overflow: TextOverflow.fade,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryText,
            softWrap: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountPicker() {
    final addedToCart = context.cart.contains(_product);
    final minValue = addedToCart ? 1 : 0;

    return WaterNumberPicker(
      value: amount,
      minValue: minValue,
      onChanged: (value) {
        if (addedToCart) {
          context.cart.add(
            AddToCart(product: _product, amount: value),
          );
        }
        setState(() => amount = value);
      },
      size: PickerSize.large,
      maxWidth: 188.0,
    );
  }

  Widget _buildDescriptionText() {
    return WaterText(
      _product.description,
      fontSize: 16.0,
      lineHeight: 2.0,
      fontWeight: FontWeight.w700,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildCheckoutPanel() {
    final addedToCart = context.cart.contains(_product);

    final totalPrice = _product.price * amount;
    final totalDiscountPrice = totalPrice * (1.0 - _product.discount);

    return BlocBuilder<CartBloc, CartState>(
      builder: (_, state) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            border: Border(top: defaultBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: WaterText(
                  'text.aed'.tr(args: [
                    totalDiscountPrice.toStringAsFixed(2),
                  ]),
                  maxLines: 1,
                  fontSize: 27.0,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                  softWrap: false,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: addedToCart
                    ? _buildCheckoutButton()
                    : _buildAddToCartButton(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddToCartButton() {
    return WaterButton(
      onPressed: () {
        context.cart.add(
          AddToCart(product: _product, amount: amount),
        );
        setState(() {});
      },
      text: 'button.add_to_cart'.tr(),
      enabled: amount > 0,
    );
  }

  Widget _buildCheckoutButton() {
    return WaterButton(
      onPressed: () {
        context.navigation.add(
          NavigateTo(screen: Screen.cart),
        );
        homeNavigator.pop();
      },
      text: 'button.checkout'.tr(),
    );
  }
}
