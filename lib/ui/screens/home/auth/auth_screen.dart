import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/screens/home/auth/auth_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isMobile ? 100.w : 50.w,
          child: Column(
            children: [
              const WaterLogo(labelWidthFactor: 2.25),
              const SizedBox(height: 128.0),
              _buildSignInButton(),
              const SizedBox(height: 12.0),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return WaterButton(
      onPressed: () {
        authNavigator.pushNamed(AuthRoutes.signIn);
      },
      text: 'button.have_account'.tr(),
    );
  }

  Widget _buildSignUpButton() {
    return WaterSecondaryButton(
      onPressed: () {
        authNavigator.pushNamed(AuthRoutes.signUp);
      },
      text: 'button.sign_up_free'.tr(),
      radialRadius: 3.0,
    );
  }
}
