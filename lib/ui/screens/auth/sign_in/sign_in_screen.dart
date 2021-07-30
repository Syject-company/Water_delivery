import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/auth_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/auth/router.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/circle_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/loader_overlay.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/password.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
  }

  final GlobalKey<FormState> _signInFormKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _emailInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _passwordInputKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

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
          controller: _scrollController,
          clipBehavior: Clip.none,
          child: Column(
            children: <Widget>[
              const WaterLogo(),
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
    return WaterText(
      'sign_in.title'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
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
              return WaterText(
                state is AuthError ? state.message : '',
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
            hintText: 'global.email'.tr(),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _passwordInputKey,
            validator: const PasswordValidator().validator,
            hintText: 'global.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AuthRoutes.forgotPassword),
      child: WaterText(
        'sign_in.forgot_password'.tr(),
        color: AppColors.primary,
        fontSize: 16.0,
        lineHeight: 1.5,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'sign_in.new_in'.tr(),
        style: const TextStyle(
          color: AppColors.secondaryText,
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
              color: AppColors.primary,
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
    return WaterText(
      'global.sign_in_with'.tr(),
      fontSize: 18.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSignInButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WaterCircleButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(FacebookLogin());
          },
          icon: AppIcons.facebook,
        ),
        const SizedBox(width: 18.0),
        WaterCircleButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(GoogleLogin());
          },
          icon: AppIcons.google,
        ),
        const SizedBox(width: 18.0),
        WaterCircleButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(AppleLogin());
          },
          icon: AppIcons.apple,
        ),
      ],
    );
  }

  Widget _buildLogInButton(BuildContext context) {
    return WaterButton(
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
