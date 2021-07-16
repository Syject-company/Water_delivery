import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/auth/router.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';

class ChooseAuthScreen extends StatelessWidget {
  const ChooseAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Logo(labelWidthFactor: 2.25),
            const SizedBox(height: 128.0),
            _buildSignInButton(context),
            const SizedBox(height: 12.0),
            _buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Button(
      onPressed: () => Navigator.of(context).pushNamed(AuthRoutes.signIn),
      text: 'choose_auth.sign_in'.tr(),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Button(
      onPressed: () => Navigator.of(context).pushNamed(AuthRoutes.signUp),
      text: 'choose_auth.sign_up'.tr(),
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.primaryColor,
    );
  }
}
