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
                imagePath: 'assets/images/bottle_1.5l.png',
                discount: true,
              ),
              ProductListItem(
                index: 2,
                text:
                    'Buxton Pure Lite Bux Pure Lite Buxton Pure Buxton Pure Buxton Pure',
                imagePath: 'assets/images/bottle_330ml.png',
              ),
              ProductListItem(
                index: 3,
                text: 'Buxton Pure Lite',
                imagePath: 'assets/images/bottle_500ml.png',
              ),
              ProductListItem(
                index: 4,
                text: 'Buxton Pure Lite Buxton Pure Lite',
                imagePath: 'assets/images/mini_cup.png',
                discount: true,
              ),
              ProductListItem(
                index: 5,
                text: 'Buxton Pure Lite',
                imagePath: 'assets/images/shrink_wrap_1.5l_v1.png',
              ),
              ProductListItem(
                index: 6,
                text: 'Buxton Pure Lite',
                imagePath: 'assets/images/shrink_wrap_500ml_v1.png',
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
    required this.imagePath,
    this.discount = false,
  }) : super(key: key);

  final String text;
  final int index;
  final String imagePath;
  final bool discount;

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  bool _addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.0),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset(widget.imagePath)),
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
        if (widget.discount)
          Row(
            children: <Widget>[
              const SizedBox(width: 12.0),
              WaterText(
                '\$27.00',
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
      color: AppColors.secondaryText,
    );
  }

  Widget _buildAddToCartButton() {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: WaterIconButton(
        onPressed: () {
          _showToast('Product has been added to the cart!');
          setState(() => _addedToCart = true);
        },
        icon: AppIcons.plus,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primaryText,
      ),
    );
  }

  Widget _buildAmountPicker() {
    return WaterNumberPicker(
      onChanged: (value) {
        if (value == 0) {
          _showToast('Product has been removed from the cart!');
          setState(() => _addedToCart = false);
        }
      },
      initialValue: 1,
      showBorder: false,
    );
  }

  void _showToast(String message) {
    return Toast.showToast(
      context,
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
            AspectRatio(aspectRatio: 1.0, child: Image.asset(widget.imagePath)),
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
