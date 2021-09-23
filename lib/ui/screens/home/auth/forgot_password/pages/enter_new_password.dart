import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/field.dart';
import 'package:water/ui/validators/password.dart';

class EnterNewPasswordPage extends StatelessWidget {
  EnterNewPasswordPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _newPasswordFormKey = GlobalKey();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isMobile ? 100.w : 50.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WaterLogo(),
              const SizedBox(height: 36.0),
              _buildEnterNewPasswordLabel(),
              const SizedBox(height: 12.0),
              _buildInputForm(context),
              const SizedBox(height: 24.0),
              _buildLogInButton(context),
            ],
          ),
        ),
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
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Form(
      key: _newPasswordFormKey,
      child: Column(
        children: [
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            buildWhen: (context, state) {
              return state is ForgotPasswordLoading ||
                  state is ForgotPasswordError;
            },
            builder: (context, state) {
              return WaterText(
                state is ForgotPasswordError ? state.message : '',
                fontSize: 15.0,
                lineHeight: 1.25,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
                color: AppColors.errorText,
              );
            },
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _codeController,
            validator: const FieldValidator(fieldName: 'Code').validator,
            hintText: 'input.code'.tr(),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _passwordController,
            validator: const PasswordValidator(fieldName: 'Password').validator,
            hintText: 'input.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _confirmPasswordController,
            validator: const PasswordValidator(fieldName: 'Confirm Password')
                .validator,
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
        if (!_newPasswordFormKey.currentState!.validate()) {
          return;
        }

        final code = _codeController.text;
        final password = _passwordController.text;
        final confirmPassword = _confirmPasswordController.text;

        context.forgotPassword.add(
          ConfirmNewPassword(
            code: code,
            password: password,
            confirmPassword: confirmPassword,
          ),
        );
      },
      text: 'button.login'.tr(),
    );
  }
}
