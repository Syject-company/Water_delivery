import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_fields.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/ui/validators/field.dart';
import 'package:water/ui/validators/password.dart';

class EnterNewPasswordPage extends StatelessWidget {
  EnterNewPasswordPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _codeInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _passwordInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _confirmPasswordInputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const WaterLogo(),
          const SizedBox(height: 36.0),
          _buildEnterNewPasswordLabel(),
          const SizedBox(height: 12.0),
          _buildInputForm(context),
          const SizedBox(height: 32.0),
          _buildLogInButton(context),
        ],
      ),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    );
  }

  Widget _buildEnterNewPasswordLabel() {
    return WaterText(
      'text.enter_new_password'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            buildWhen: (_, state) =>
                state is ForgotPasswordLoading || state is ForgotPasswordError,
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
            key: _codeInputKey,
            validator: const FieldValidator(fieldName: 'Code').validator,
            hintText: 'input.code'.tr(),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _passwordInputKey,
            validator: const PasswordValidator().validator,
            hintText: 'input.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _confirmPasswordInputKey,
            validator:
                const FieldValidator(fieldName: 'Confirm Password').validator,
            hintText: 'input.confirm_password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildLogInButton(BuildContext context) {
    return WaterButton(
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
      text: 'button.login'.tr(),
    );
  }
}
