import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/auth/router.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/logo.dart';

class ChooseAuthScreen extends StatelessWidget {
  const ChooseAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Logo(),
                const SizedBox(height: 96.0),
                _buildSignInButton(context),
                const SizedBox(height: 12.0),
                _buildSignUpButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Button(
      onPressed: () {
        Navigator.of(context).pushNamed(AuthRoutes.SignIn);
      },
      text: 'button.sign_in'.tr(),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Button(
      onPressed: () {},
      text: 'button.sign_up'.tr(),
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.primaryColor,
    );
  }
}
