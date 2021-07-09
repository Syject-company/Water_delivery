import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Logo(labelWidthFactor: 3.0),
            const SizedBox(height: 96.0),
            _buildSignInButton(),
            const SizedBox(height: 12.0),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Button(
      onPressed: () {},
      text: 'button.sign_in'.tr(),
    );
  }

  Widget _buildSignUpButton() {
    return Button(
      onPressed: () {},
      text: 'button.sign_up'.tr(),
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.primaryColor,
    );
  }
}
