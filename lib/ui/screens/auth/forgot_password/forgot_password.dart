import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_cubit.dart';
import 'package:water/ui/screens/auth/forgot_password/pages/enter_new_password.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';

import 'pages/enter_email.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (_, state) {
            if (state is ForgotPasswordNewPasswordInput) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 375),
                curve: Curves.easeInOutCubic,
              );
            }
          },
          builder: (_, state) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                EnterEmail(),
                EnterNewPassword(),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: AppBarBackButton(
        // onPressed: () => Navigator.of(context).pop(),
        onPressed: () => _pageController.previousPage(
          duration: Duration(milliseconds: 375),
          curve: Curves.easeInOutCubic,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}
