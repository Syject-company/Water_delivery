import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/number_picker.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class ShoppingCartItemData {}

class ShoppingCartScreen extends StatefulWidget {
  ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<ShoppingCartItem> _items = [
    ShoppingCartItem(),
    ShoppingCartItem(),
    ShoppingCartItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _items.isNotEmpty ? _buildItems() : _buildEmptyCartText(),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildBottomPanel(),
        )
      ],
    );
  }

  Widget _buildEmptyCartText() {
    return Expanded(
      child: Center(
        child: WaterText(
          'Cart is Empty',
          fontSize: 20.0,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildItems() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: _items,
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Column(
        children: <Widget>[
          _buildDiscountPriceText(),
          const SizedBox(height: 8.0),
          _buildTotalPriceText(),
          const SizedBox(height: 16.0),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildDiscountPriceText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: WaterText(
              'Fee',
              fontSize: 18.0,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: WaterText(
              '\$0.00',
              fontSize: 18.0,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: WaterText(
              'Total',
              fontSize: 23.0,
              lineHeight: 2.0,
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: WaterText(
              '\$43.26',
              fontSize: 23.0,
              lineHeight: 2.0,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: WaterButton(
            onPressed: () {},
            text: 'Subscription',
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: WaterButton(
            onPressed: () {},
            text: 'Check Out',
          ),
        ),
      ],
    );
  }
}

class ShoppingCartItem extends StatefulWidget {
  const ShoppingCartItem({Key? key}) : super(key: key);

  @override
  _ShoppingCartItemState createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 24.0, 12.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 80,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.asset('assets/images/bottle_1.5l.png'),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: WaterText(
                        'Buxton Pure Lite Buxton Pure Lite Buxton Pure Lite',
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Icon(
                      Icons.close,
                      size: 26.0,
                      color: AppColors.secondaryText,
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: WaterNumberPicker(
                        alignment: AlignmentDirectional.centerStart,
                        onChanged: (value) {},
                        size: PickerSize.small,
                        showBorder: false,
                        maxWidth: 112.0,
                        minValue: 1,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          WaterText(
                            '\$25.00',
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
