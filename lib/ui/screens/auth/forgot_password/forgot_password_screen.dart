import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/loader_overlay.dart';

import 'pages/enter_email.dart';
import 'pages/enter_new_password.dart';

const Duration _pageSwapDuration = Duration(milliseconds: 375);

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (_, state) {
        state is ForgotPasswordLoading
            ? context.showLoader()
            : context.hideLoader();

        if (state is ForgotPasswordNewPasswordInput) {
          _pageController.nextPage(
            duration: _pageSwapDuration,
            curve: Curves.easeInOutCubic,
          );
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          clipBehavior: Clip.none,
          children: <Widget>[
            EnterEmailPage(),
            EnterNewPasswordPage(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: AppBarBackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
