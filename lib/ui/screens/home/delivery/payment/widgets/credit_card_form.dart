import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

class CreditCardForm extends StatelessWidget {
  CreditCardForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildAddCardButton(context),
      ],
    );
  }

  Widget _buildAddCardButton(BuildContext context) {
    return WaterButton(
      onPressed: () {},
      text: 'button.add_card'.tr(),
    );
  }
}
