import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
import 'package:water/bloc/home/navigation/navigation_bloc.dart';
import 'package:water/domain/model/home/shop/product.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_notification_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/number_picker.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _checkOutPanelHeight = 80.0;
const EdgeInsetsGeometry _checkoutPanelContentPadding =
    EdgeInsets.symmetric(vertical: 0.0, horizontal: 32.0);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 32.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LayoutBuilder(
              builder: (_, constraints) {
                return Hero(
                  tag: _product,
                  child: Image.asset(
                    _product.imageUri,
                    height: constraints.maxWidth,
                  ),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(child: _buildTitleText()),
                    const SizedBox(width: 16.0),
                    _buildVolumeText(),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(flex: 2, child: _buildPriceText()),
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
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (_, state) => _buildCheckoutPanel(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      leading: AppBarBackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        AppBarIconButton(
          icon: AppIcons.whatsapp,
          onPressed: () {},
        ),
        AppBarNotificationButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildTitleText() {
    return WaterText(
      _product.title.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
    );
  }

  Widget _buildVolumeText() {
    final String volume;
    if (_product.volume < 1.0) {
      volume = '${(_product.volume * 1000).toInt()}${'global.milliliter'.tr()}';
    } else {
      volume = '${_product.volume}${'global.liter'.tr()}';
    }

    return WaterText(
      volume,
      fontSize: 24.0,
      lineHeight: 2.0,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildPriceText() {
    final sale = _product.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final price = _product.price;
    final discountPrice = price - (price * discount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (discount > 0.0)
          Column(
            children: <Widget>[
              WaterText(
                'AED ${price.toStringAsFixed(2)}',
                maxLines: 1,
                fontSize: 18.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.fade,
                decoration: TextDecoration.lineThrough,
                color: AppColors.secondaryText,
                softWrap: false,
              ),
              const SizedBox(height: 6.0),
            ],
          ),
        WaterText(
          'AED ${discountPrice.toStringAsFixed(2)}',
          maxLines: 1,
          fontSize: 27.0,
          lineHeight: 2,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.fade,
          softWrap: false,
        ),
      ],
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
      _product.description.tr(),
      fontSize: 16.0,
      lineHeight: 2.0,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildCheckoutPanel() {
    final addedToCart = context.cart.contains(_product);

    final sale = _product.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final totalPrice = _product.price * amount;
    final totalDiscountPrice = totalPrice - (totalPrice * discount);

    return Container(
      padding: _checkoutPanelContentPadding,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.borderColor),
        ),
      ),
      height: _checkOutPanelHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: WaterText(
              'AED ${totalDiscountPrice.toStringAsFixed(2)}',
              maxLines: 1,
              fontSize: 27.0,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
              child: addedToCart
                  ? _buildCheckoutButton()
                  : _buildAddToCartButton()),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return WaterButton(
      onPressed: amount > 0
          ? () {
              context.cart.add(
                AddToCart(product: _product, amount: amount),
              );
              setState(() {});
            }
          : null,
      text: 'Add To Cart',
      backgroundColor: amount > 0 ? AppColors.primary : AppColors.disabled,
      foregroundColor: amount > 0 ? AppColors.white : AppColors.white,
    );
  }

  Widget _buildCheckoutButton() {
    return WaterButton(
      onPressed: () {
        context.navigation.add(
          NavigateTo(screen: Screen.cart),
        );
        Navigator.of(context).pop();
      },
      text: 'Checkout',
    );
  }
}
