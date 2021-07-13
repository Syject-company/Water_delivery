import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo.dart';
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
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
                _buildSignUpButtons(),
                const SizedBox(height: 24.0),
                _buildRegisterButton(context),
              ],
            ),
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
    return Text(
      'sign_up.title'.tr(),
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ).poppins,
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<SignUpBloc, SignUpState>(
            builder: (_, state) {
              return Text(
                state is SignUpError ? state.error : '',
                style: const TextStyle(
                  color: AppColors.errorTextColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ).poppins,
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
    return Text(
      'global.sign_up_with'.tr(),
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ).poppins,
    );
  }

  Widget _buildSignUpButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RoundedButton(
          onPressed: () {},
          iconPath: 'assets/svg/facebook.svg',
        ),
        const SizedBox(width: 18.0),
        RoundedButton(
          onPressed: () {},
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

    context.signUpBloc.register(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
