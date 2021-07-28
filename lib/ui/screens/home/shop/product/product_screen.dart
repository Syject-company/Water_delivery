import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/cart/cart_bloc.dart';
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

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (_, constraints) {
                  return Image.asset(
                    product.imageUri,
                    height: constraints.maxWidth,
                  );
                },
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(child: _buildTitleText()),
                  const SizedBox(width: 32.0),
                  _buildCapacityText(),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(flex: 2, child: _buildPriceText()),
                  const SizedBox(width: 32.0),
                  Flexible(flex: 3, child: _buildAmountPicker(context)),
                ],
              ),
              const SizedBox(height: 16.0),
              _buildDescriptionText(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (_, state) => _buildCheckoutPanel(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
          onPressed: () {},
          notificationsCount: 9,
        ),
      ],
    );
  }

  Widget _buildTitleText() {
    return WaterText(
      product.title,
      fontSize: 24.0,
      lineHeight: 2.0,
    );
  }

  Widget _buildCapacityText() {
    return WaterText(
      '${product.volume} LT',
      fontSize: 24.0,
      lineHeight: 2.0,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildPriceText() {
    final sale = product.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final price = product.price;
    final discountPrice = price - (price * discount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (discount > 0.0)
          Column(
            children: <Widget>[
              WaterText(
                '\$${price.toStringAsFixed(2)}',
                maxLines: 1,
                fontSize: 18.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
                decoration: TextDecoration.lineThrough,
                color: AppColors.secondaryText,
              ),
              const SizedBox(height: 6.0),
            ],
          ),
        WaterText(
          '\$${discountPrice.toStringAsFixed(2)}',
          maxLines: 1,
          fontSize: 27.0,
          lineHeight: 2,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildAmountPicker(BuildContext context) {
    final item = context.cart.getItemById(product.id);

    return WaterNumberPicker(
      value: item?.amount ?? 0,
      onChanged: (value) {
        if (value == 0) {
          context.cart.add(
            RemoveFromCart(product: product),
          );
        } else {
          context.cart.add(
            AddToCart(product: product, amount: value),
          );
        }
      },
      size: PickerSize.large,
    );
  }

  Widget _buildDescriptionText() {
    return WaterText(
      product.description,
      fontSize: 16.0,
      lineHeight: 2.0,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildCheckoutPanel(BuildContext context) {
    final item = context.cart.getItemById(product.id);

    final sale = product.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final totalPrice = product.price * (item?.amount ?? 0);
    final totalDiscountPrice = totalPrice - (totalPrice * discount);

    return Container(
      padding: _checkoutPanelContentPadding,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      height: _checkOutPanelHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: WaterText(
              '\$${totalDiscountPrice.toStringAsFixed(2)}',
              maxLines: 1,
              fontSize: 27.0,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: WaterButton(
              onPressed: () {},
              text: 'Add To Cart',
            ),
          ),
        ],
      ),
    );
  }
}
