import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
import 'package:water/ui/validators/email.dart';

class EnterNewPassword extends StatelessWidget {
  EnterNewPassword({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormInputState> _codeInputKey = GlobalKey();
  final GlobalKey<FormInputState> _passwordInputKey = GlobalKey();
  final GlobalKey<FormInputState> _confirmPasswordInputKey = GlobalKey();

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
          _buildEnterNewPasswordLabel(),
          const SizedBox(height: 32.0),
          _buildInputForm(),
          const SizedBox(height: 32.0),
          _buildLogInButton(context),
        ],
      ),
    );
  }

  Widget _buildEnterNewPasswordLabel() {
    return Label(
      'forgot_password.enter_new_password.title'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          FormInput(
            key: _codeInputKey,
            validator: const EmailValidator().validator,
            labelText: 'global.code'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _passwordInputKey,
            validator: const EmailValidator().validator,
            labelText: 'global.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _confirmPasswordInputKey,
            validator: const EmailValidator().validator,
            labelText: 'global.confirm_password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildLogInButton(BuildContext context) {
    return Button(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // TODO: successful sign in
        } else {
          // TODO: show error text
        }
      },
      text: 'forgot_password.enter_new_password.login'.tr(),
    );
  }
}
