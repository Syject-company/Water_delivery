import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/forgot_password/forgot_password_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_fields.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/ui/validators/email.dart';

class EnterEmailPage extends StatelessWidget {
  EnterEmailPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _emailInputKey = GlobalKey();

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
          _buildForgotPasswordLabel(),
          const SizedBox(height: 12.0),
          _buildInputForm(),
          const SizedBox(height: 32.0),
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
      key: _formKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
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
            key: _emailInputKey,
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
        if (!_formKey.currentState!.validate()) {
          return;
        }

        final email = _emailInputKey.currentState!.value;
        context.forgotPassword.add(ResetPassword(email: email));
      },
      text: 'button.reset_password'.tr(),
    );
  }
}
