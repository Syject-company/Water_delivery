import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/auth_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/constants/paths.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/screens/auth/router.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/loader_overlay.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/password.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _signInFormKey = GlobalKey();
  final GlobalKey<FormInputState> _emailInputKey = GlobalKey();
  final GlobalKey<FormInputState> _passwordInputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) {
        state is AuthLoading ? context.showLoader() : context.hideLoader();

        if (state is AuthSuccess) {
          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(AppRoutes.home);
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Logo(),
              const SizedBox(height: 36.0),
              _buildSignInLabel(),
              const SizedBox(height: 12.0),
              _buildInputForm(),
              const SizedBox(height: 24.0),
              _buildForgotPasswordLink(context),
              const SizedBox(height: 16.0),
              _buildSignUpLink(context),
              const SizedBox(height: 32.0),
              _buildSignUpLabel(),
              const SizedBox(height: 24.0),
              _buildSignInButtons(context),
              const SizedBox(height: 24.0),
              _buildLogInButton(context),
            ],
          ),
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

  Widget _buildSignInLabel() {
    return Label(
      'sign_in.title'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (_, state) =>
                (state is AuthLoading || state is AuthError),
            builder: (_, state) {
              return Label(
                state is AuthError ? state.message : '',
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
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _passwordInputKey,
            validator: const PasswordValidator().validator,
            labelText: 'global.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AuthRoutes.forgotPassword),
      child: Label(
        'sign_in.forgot_password'.tr(),
        color: AppColors.primaryColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        lineHeight: 1.5,
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'sign_in.new_in'.tr(),
        style: const TextStyle(
          color: AppColors.secondaryTextColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ).poppins,
        children: <TextSpan>[
          TextSpan(
            text: 'sign_in.sign_up'.tr(),
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => Navigator.of(context).pushNamed(AuthRoutes.signUp),
            style: const TextStyle(
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
      strutStyle: const StrutStyle(
        forceStrutHeight: true,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSignUpLabel() {
    return Label(
      'global.sign_in_with'.tr(),
      fontSize: 18.0,
      lineHeight: 1.5,
    );
  }

  Widget _buildSignInButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RoundedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(FacebookLogin());
          },
          iconPath: Paths.facebookIcon,
        ),
        const SizedBox(width: 18.0),
        RoundedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(GoogleLogin());
          },
          iconPath: Paths.googleIcon,
        ),
        const SizedBox(width: 18.0),
        RoundedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(AppleLogin());
          },
          iconPath: Paths.appleIcon,
        ),
      ],
    );
  }

  Widget _buildLogInButton(BuildContext context) {
    return Button(
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (!_signInFormKey.currentState!.validate()) {
          return;
        }

        final email = _emailInputKey.currentState!.value;
        final password = _passwordInputKey.currentState!.value;

        context.auth.add(Login(
          email: email,
          password: password,
        ));
      },
      text: 'sign_in.login'.tr(),
    );
  }
}
