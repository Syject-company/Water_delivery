import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
import 'package:water/ui/validators/email.dart';

class EnterEmail extends StatelessWidget {
  EnterEmail({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormInputState> _emailInputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Logo(),
          const SizedBox(height: 36.0),
          _buildForgotPasswordLabel(),
          const SizedBox(height: 12.0),
          _buildInputForm(),
          const SizedBox(height: 32.0),
          _buildResetPasswordButton(context),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordLabel() {
    return Label(
      'forgot_password.enter_email.title'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (_, state) {
              return Label(
                state is ForgotPasswordError ? state.message : '',
                color: AppColors.errorTextColor,
                fontSize: 15.0,
                lineHeight: 1.25,
              );
            },
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _emailInputKey,
            validator: const EmailValidator().validator,
            labelText: 'global.email'.tr(),
            keyboardType: TextInputType.emailAddress,
          )
        ],
      ),
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    return Button(
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
          // TODO: show error text
          return;
        }

        final email = _emailInputKey.currentState!.value;
        context.forgotPassword.add(ResetPassword(email: email));
      },
      text: 'forgot_password.enter_email.reset_password'.tr(),
    );
  }
}
