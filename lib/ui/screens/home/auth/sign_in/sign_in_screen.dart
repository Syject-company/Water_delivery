import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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

  final GlobalKey<FormState> _signInFormKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) {
        context.showLoader(state is Authenticating);

        if (state is Authenticated) {
          homeNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      leading: AppBarBackButton(
        onPressed: () {
          authNavigator.pop();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
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
          _buildForgotPasswordLink(),
          const SizedBox(height: 16.0),
          _buildSignUpLink(),
          const SizedBox(height: 32.0),
          _buildSignUpLabel(),
          const SizedBox(height: 24.0),
          _buildSignInButtons(context),
          const SizedBox(height: 24.0),
          _buildLogInButton(context),
        ],
      ),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    );
  }

  Widget _buildSignInLabel() {
    return WaterText(
      'text.sign_in'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (_, state) {
              return state is Authenticating || state is AuthenticationFailed;
            },
            builder: (_, state) {
              return WaterText(
                state is AuthenticationFailed ? state.message : '',
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
            controller: _emailController,
            validator: const EmailValidator().validator,
            hintText: 'input.email'.tr(),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _passwordController,
            validator: const PasswordValidator(fieldName: 'Password').validator,
            hintText: 'input.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return GestureDetector(
      onTap: () {
        authNavigator.pushNamed(AuthRoutes.forgotPassword);
      },
      child: WaterText(
        'text.forgot_your_password'.tr(),
        fontSize: 16.0,
        lineHeight: 1.5,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildSignUpLink() {
    return RichText(
      text: TextSpan(
        text: 'text.new_in'.tr(),
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryText,
        ).nunitoSans,
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
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
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
        if (!_signInFormKey.currentState!.validate()) {
          return;
        }

        final email = _emailController.text;
        final password = _passwordController.text;

        context.auth.add(
          Login(
            email: email,
            password: password,
          ),
        );
      },
      text: 'button.login'.tr(),
    );
  }
}
