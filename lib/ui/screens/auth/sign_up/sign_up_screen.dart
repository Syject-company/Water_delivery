import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:water/bloc/auth/social/social_auth_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/field.dart';
import 'package:water/ui/validators/password.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  final GlobalKey<FormState> _signUpFormKey = GlobalKey();
  final GlobalKey<FormInputState> _emailInputKey = GlobalKey();
  final GlobalKey<FormInputState> _passwordInputKey = GlobalKey();
  final GlobalKey<FormInputState> _confirmPasswordInputKey =
      GlobalKey<FormInputState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Logo(),
            const SizedBox(height: 36.0),
            _buildCreateAccountLabel(),
            const SizedBox(height: 12.0),
            _buildInputForm(context),
            const SizedBox(height: 48.0),
            _buildSignUpLabel(),
            const SizedBox(height: 24.0),
            _buildSignUpButtons(context),
            const SizedBox(height: 24.0),
            _buildRegisterButton(context),
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

  Widget _buildCreateAccountLabel() {
    return Label(
      'sign_up.title'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (_, state) {
              return Label(
                state is SignUpError ? state.message : '',
                color: AppColors.errorTextColor,
                fontSize: 15.0,
                lineHeight: 1.25,
              );
            },
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _emailInputKey,
            labelText: 'global.email'.tr(),
            validator: const EmailValidator().validator,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _passwordInputKey,
            labelText: 'global.password'.tr(),
            validator: const PasswordValidator().validator,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _confirmPasswordInputKey,
            labelText: 'global.confirm_password'.tr(),
            validator:
                const FieldValidator(fieldName: 'Confirm Password').validator,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpLabel() {
    return Label(
      'global.sign_up_with'.tr(),
      fontSize: 18.0,
      lineHeight: 1.5,
    );
  }

  Widget _buildSignUpButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RoundedButton(
          onPressed: () => context.socialAuth.add(SignInWithFacebook()),
          iconPath: 'assets/svg/facebook.svg',
        ),
        const SizedBox(width: 18.0),
        RoundedButton(
          onPressed: () => context.socialAuth.add(SignInWithGoogle()),
          iconPath: 'assets/svg/google.svg',
        ),
        const SizedBox(width: 18.0),
        RoundedButton(
          onPressed: () {},
          iconPath: 'assets/svg/apple.svg',
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Button(
      onPressed: () {
        if (!_signUpFormKey.currentState!.validate()) {
          // TODO: show error text
          return;
        }

        final email = _emailInputKey.currentState!.value;
        final password = _passwordInputKey.currentState!.value;
        final confirmPassword = _confirmPasswordInputKey.currentState!.value;

        context.signUp.add(Register(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ));
      },
      text: 'sign_up.register'.tr(),
    );
  }
}
