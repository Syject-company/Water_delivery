import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/ui/screens/home/auth/auth_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/password.dart';
import 'package:water/util/separated_row.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _signUpFormKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
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
    return LoaderOverlay(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          context.showLoader(state is Authenticating);

          if (state is Authenticated) {
            homeNavigator.pop();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
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
                  _buildCreateAccountLabel(),
                  const SizedBox(height: 12.0),
                  _buildInputForm(),
                  const SizedBox(height: 40.0),
                  _buildSignUpLabel(),
                  const SizedBox(height: 24.0),
                  _buildSignUpButtons(context),
                  const SizedBox(height: 24.0),
                  _buildRegisterButton(context),
                ],
              ),
            ),
          ),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        ),
      ),
    );
  }

  Widget _buildCreateAccountLabel() {
    return WaterText(
      'text.create_account'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _signUpFormKey,
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
            hintText: 'input.email'.tr(),
            validator: const EmailValidator().validator,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _passwordController,
            hintText: 'input.password'.tr(),
            validator: const PasswordValidator(fieldName: 'Password').validator,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _confirmPasswordController,
            hintText: 'input.confirm_password'.tr(),
            validator: const PasswordValidator(fieldName: 'Confirm Password')
                .validator,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpLabel() {
    return WaterText(
      'text.sign_up_with'.tr(),
      fontSize: 18.0,
      lineHeight: 1.5,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    );
  }

  Widget _buildSignUpButtons(BuildContext context) {
    return SeparatedRow(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WaterSocialButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.auth.add(FacebookLogin());
          },
          icon: AppIcons.facebook,
        ),
        WaterSocialButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.auth.add(GoogleLogin());
          },
          icon: AppIcons.google,
        ),
        if (Platform.isIOS)
          WaterSocialButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.auth.add(AppleLogin());
            },
            icon: AppIcons.apple,
          ),
      ],
      separator: const SizedBox(width: 18.0),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();

        if (!_signUpFormKey.currentState!.validate()) {
          return;
        }

        final email = _emailController.text;
        final password = _passwordController.text;
        final confirmPassword = _confirmPasswordController.text;

        context.auth.add(
          Register(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          ),
        );
      },
      text: 'button.register'.tr(),
    );
  }
}
