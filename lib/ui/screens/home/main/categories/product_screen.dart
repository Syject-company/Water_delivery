import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/appbar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/number_picker.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _checkoutPanelHeight = 80.0;
const EdgeInsetsGeometry _checkoutPanelContentPadding =
    EdgeInsets.symmetric(vertical: 0.0, horizontal: 32.0);

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 32.0),
          child: Column(
            children: [
              LayoutBuilder(
                builder: (_, constraints) {
                  return Image.asset(
                    'assets/images/bottle_1.5l.png',
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
                  Flexible(flex: 3, child: _buildAmountPicker()),
                ],
              ),
              const SizedBox(height: 16.0),
              _buildDescriptionText(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCheckoutPanel(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 72.0,
      leading: AppBarBackButton(
        onPressed: () {},
      ),
      actions: <Widget>[
        AppBarIconButton(
          icon: AppIcons.whatsapp,
          onPressed: () {},
        ),
        AppBarIconButton(
          icon: AppIcons.notification,
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget _buildTitleText() {
    return WaterText(
      'Buxton Pure Lite',
      fontSize: 24.0,
      lineHeight: 2.0,
    );
  }

  Widget _buildCapacityText() {
    return WaterText(
      '0.33LT',
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.right,
      color: AppColors.secondaryTextColor,
    );
  }

  Widget _buildPriceText() {
    return WaterText(
      '\$235.00',
      maxLines: 1,
      fontSize: 27.0,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  Widget _buildAmountPicker() {
    return WaterNumberPicker(
      onChanged: (value) {},
      size: PickerSize.large,
    );
  }

  Widget _buildDescriptionText() {
    return WaterText(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
      'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco '
      'laboris nisi ut aliquip ex ea commodo consequat.',
      fontSize: 16.0,
      lineHeight: 2.0,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextColor,
    );
  }

  Widget _buildCheckoutPanel() {
    return Container(
      padding: _checkoutPanelContentPadding,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      height: _checkoutPanelHeight,
      child: Row(
        children: <Widget>[
          WaterText(
            '\$235.00',
            fontSize: 27.0,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(width: 32.0),
          Expanded(
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
