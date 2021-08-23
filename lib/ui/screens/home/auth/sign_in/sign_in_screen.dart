import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/screens/home/auth/auth_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/password.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _emailInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _passwordInputKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        context.showLoader(state is Authenticating);

        if (state is Authenticated) {
          homeNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          clipBehavior: Clip.none,
          child: Column(
            children: [
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

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: WaterAppBar(
        leading: AppBarBackButton(
          onPressed: () {
            authNavigator.pop();
          },
        ),
      ),
    );
  }

  Widget _buildSignInLabel() {
    return WaterText(
      'text.sign_in'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (context, state) {
              return state is Authenticating || state is AuthenticationFailed;
            },
            builder: (context, state) {
              return WaterText(
                state is AuthenticationFailed ? state.message : '',
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
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _passwordInputKey,
            validator: const PasswordValidator().validator,
            hintText: 'input.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return GestureDetector(
      onTap: () {
        authNavigator.pushNamed(AuthRoutes.forgotPassword);
      },
      child: WaterText(
        'text.forgot_your_password'.tr(),
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
        text: 'text.new_in'.tr(),
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ).poppins,
        children: <TextSpan>[
          TextSpan(
            text: 'text.sign_up'.tr(),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                authNavigator.pushNamed(AuthRoutes.signUp);
              },
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
      'text.sign_in_with'.tr(),
      fontSize: 18.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSignInButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WaterSocialButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(FacebookLogin());
          },
          icon: AppIcons.facebook,
        ),
        const SizedBox(width: 18.0),
        WaterSocialButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(GoogleLogin());
          },
          icon: AppIcons.google,
        ),
        const SizedBox(width: 18.0),
        WaterSocialButton(
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
        if (!_formKey.currentState!.validate()) {
          return;
        }

        final email = _emailInputKey.currentState!.value;
        final password = _passwordInputKey.currentState!.value;

        context.auth.add(
          Login(email: email, password: password),
        );
      },
      text: 'button.login'.tr(),
    );
  }
}
