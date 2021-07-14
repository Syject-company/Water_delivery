import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/auth_cubit.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
import 'package:water/ui/validators/email.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Logo(),
              const SizedBox(height: 32.0),
              _buildCreateAccountLabel(),
              const SizedBox(height: 8.0),
              _buildInputForm(context),
              const SizedBox(height: 32.0),
              _buildSignUpLabel(),
              const SizedBox(height: 24.0),
              _buildSignUpButtons(context),
              const SizedBox(height: 24.0),
              _buildRegisterButton(context),
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
          BlocBuilder<AuthCubit, AuthState>(
            builder: (_, state) {
              return Label(
                state is AuthError ? state.error : '',
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
            onEditingComplete: () => _register(context),
            validator: const EmailValidator().validator,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _passwordInputKey,
            labelText: 'global.password'.tr(),
            onEditingComplete: () => _register(context),
            validator: const PasswordValidator().validator,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            key: _confirmPasswordInputKey,
            labelText: 'global.confirm_password'.tr(),
            onEditingComplete: () => _register(context),
            validator: const PasswordValidator().validator,
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
          onPressed: () => context.authCubit.signInWithFacebook(),
          iconPath: 'assets/svg/facebook.svg',
        ),
        const SizedBox(width: 18.0),
        RoundedButton(
          onPressed: () => context.authCubit.signInWithGoogle(),
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
        _register(context);

        _signUpFormKey.currentState!.save();
        // if (_signUpFormKey.currentState!.validate()) {
        //   // TODO: handle sign up
        // } else {
        //   // TODO: show error text
        // }
      },
      text: 'sign_up.register'.tr(),
    );
  }

  void _register(BuildContext context) {
    final email = _emailInputKey.currentState!.value;
    final password = _passwordInputKey.currentState!.value;
    final confirmPassword = _confirmPasswordInputKey.currentState!.value;

    context.authCubit.signUp(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
