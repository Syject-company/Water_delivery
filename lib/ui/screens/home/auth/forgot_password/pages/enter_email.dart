import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/email.dart';

class EnterEmailPage extends StatelessWidget {
  EnterEmailPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _emailFormKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const WaterLogo(),
          const SizedBox(height: 36.0),
          _buildForgotPasswordLabel(),
          const SizedBox(height: 12.0),
          _buildInputForm(),
          const SizedBox(height: 24.0),
          _buildResetPasswordButton(context),
        ],
      ),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    );
  }

  Widget _buildForgotPasswordLabel() {
    return WaterText(
      'text.forgot_password'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _emailFormKey,
      child: Column(
        children: [
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            buildWhen: (_, state) {
              return state is ForgotPasswordLoading ||
                  state is ForgotPasswordError;
            },
            builder: (_, state) {
              return WaterText(
                state is ForgotPasswordError ? state.message : '',
                fontSize: 15.0,
                lineHeight: 1.25,
                textAlign: TextAlign.center,
                color: AppColors.errorText,
              );
            },
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _emailController,
            validator: const EmailValidator().validator,
            hintText: 'input.email'.tr(),
            keyboardType: TextInputType.emailAddress,
          )
        ],
      ),
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (!_emailFormKey.currentState!.validate()) {
          return;
        }

        final email = _emailController.text;

        context.forgotPassword.add(
          ResetPassword(email: email),
        );
      },
      text: 'button.reset_password'.tr(),
    );
  }
}
