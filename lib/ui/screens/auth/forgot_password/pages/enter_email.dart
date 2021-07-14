import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_cubit.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo.dart';
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
          const SizedBox(height: 32.0),
          _buildForgotPasswordLabel(),
          const SizedBox(height: 32.0),
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
      child: FormInput(
        key: _emailInputKey,
        validator: const EmailValidator().validator,
        labelText: 'global.email'.tr(),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    return Button(
      onPressed: () {
        context.forgotPasswordCubit.resetPassword();

        if (_formKey.currentState!.validate()) {
          // TODO: successful sign in
        } else {
          // TODO: show error text
        }
      },
      text: 'forgot_password.enter_email.reset_password'.tr(),
    );
  }
}
