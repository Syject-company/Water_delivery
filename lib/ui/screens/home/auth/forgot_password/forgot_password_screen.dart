import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/screens/home/auth/auth_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'pages/enter_email.dart';
import 'pages/enter_new_password.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (_, state) {
        context.showLoader(state is ForgotPasswordLoading);

        if (state is NewPasswordInput) {
          _pageController.jumpToPage(1);
        } else if (state is ForgotPasswordSuccess) {
          homeNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      leading: AppBarBackButton(
        onPressed: () {
          authNavigator.pop();
        },
      ),
    );
  }

  Widget _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      clipBehavior: Clip.none,
      children: [
        EnterEmailPage(),
        EnterNewPasswordPage(),
      ],
    );
  }
}
