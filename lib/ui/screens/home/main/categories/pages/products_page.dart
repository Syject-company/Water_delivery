import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/button/icon_button.dart';
import 'package:water/ui/shared_widgets/number_picker.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/ui/shared_widgets/toast.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 24.0),
        Expanded(
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            crossAxisCount: 2,
            childAspectRatio: 0.67,
            children: <Widget>[
              ProductListItem(
                index: 1,
                text: 'Buxton Pure Lite',
                path: 'assets/images/bottle_1.5l.png',
                discount: true,
              ),
              ProductListItem(
                index: 2,
                text:
                    'Buxton Pure Lite Bux Pure Lite Buxton Pure Buxton Pure Buxton Pure',
                path: 'assets/images/bottle_330ml.png',
              ),
              ProductListItem(
                index: 3,
                text: 'Buxton Pure Lite',
                path: 'assets/images/bottle_500ml.png',
              ),
              ProductListItem(
                index: 4,
                text: 'Buxton Pure Lite Buxton Pure Lite',
                path: 'assets/images/mini_cup.png',
                discount: true,
              ),
              ProductListItem(
                index: 5,
                text: 'Buxton Pure Lite',
                path: 'assets/images/shrink_wrap_1.5l_v1.png',
              ),
              ProductListItem(
                index: 6,
                text: 'Buxton Pure Lite',
                path: 'assets/images/shrink_wrap_500ml_v1.png',
                discount: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductListItem extends StatefulWidget {
  const ProductListItem({
    Key? key,
    required this.text,
    required this.index,
    required this.path,
    this.discount = false,
  }) : super(key: key);

  final String text;
  final int index;
  final String path;
  final bool discount;

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  bool _addedToCart = false;
  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(19.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: Image.asset(widget.path)),
            const SizedBox(height: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
            _addedToCart ? _buildAmountPicker() : _buildAddToCartButton()
          ],
        ),
      ),
    );
  }

  Widget _buildPriceText() {
    return Row(
      children: <Widget>[
        WaterText(
          '\$25.00',
          maxLines: 1,
          fontSize: 19.0,
          lineHeight: 1.5,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
        if (widget.discount) const SizedBox(width: 12.0),
        if (widget.discount)
          WaterText(
            '\$27.00',
            maxLines: 1,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            decoration: TextDecoration.lineThrough,
            color: AppColors.secondaryTextColor,
          ),
      ],
    );
  }

  Widget _buildTitleText() {
    return WaterText(
      widget.text,
      maxLines: 2,
      fontSize: 15.0,
      lineHeight: 1.5,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCapacityText() {
    return WaterText(
      '0.33 LT',
      maxLines: 1,
      fontSize: 15.0,
      lineHeight: 1.5,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      color: AppColors.secondaryTextColor,
    );
  }

  Widget _buildAddToCartButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: WaterIconButton(
        onPressed: () {
          setState(() {
            _amount += 1;
            _addedToCart = true;
          });
        },
        icon: AppIcons.plus,
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: AppColors.primaryTextColor,
      ),
    );
  }

  Widget _buildAmountPicker() {
    return WaterNumberPicker(
      onChanged: (value) {
        print(value);
        setState(() {
          _addedToCart = value > 0;
        });
        Toast.showToast(
          context,
          child: Container(
            padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(19.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0.0,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: WaterText(
                'Product has been added to the cart!',
                fontSize: 16.0,
              ),
            ),
          ),
          duration: const Duration(seconds: 2),
        );
      },
      initialValue: 1,
      showBorder: false,
    );
  }
}
