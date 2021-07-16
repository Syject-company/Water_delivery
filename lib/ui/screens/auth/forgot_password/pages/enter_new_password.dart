import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
import 'package:water/ui/validators/field.dart';
import 'package:water/ui/validators/password.dart';

class EnterNewPasswordPage extends StatelessWidget {
  EnterNewPasswordPage({Key? key}) : super(key: key);

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
          const SizedBox(height: 36.0),
          _buildEnterNewPasswordLabel(),
          const SizedBox(height: 12.0),
          _buildInputForm(context),
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

  Widget _buildInputForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            buildWhen: (previousState, state) =>
                state is ForgotPasswordLoading || state is ForgotPasswordError,
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
            key: _codeInputKey,
            validator: const FieldValidator(fieldName: 'Code').validator,
            labelText: 'global.code'.tr(),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _passwordInputKey,
            validator: const PasswordValidator().validator,
            labelText: 'global.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _confirmPasswordInputKey,
            validator:
                const FieldValidator(fieldName: 'Confirm Password').validator,
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
        FocusScope.of(context).unfocus();
        if (!_formKey.currentState!.validate()) {
          return;
        }

        final code = _codeInputKey.currentState!.value;
        final password = _passwordInputKey.currentState!.value;
        final confirmPassword = _confirmPasswordInputKey.currentState!.value;

        context.forgotPassword.add(ConfirmNewPassword(
          code: code,
          password: password,
          confirmPassword: confirmPassword,
        ));
      },
      text: 'forgot_password.enter_new_password.login'.tr(),
    );
  }
}
