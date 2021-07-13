import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/screens/auth/router.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/password.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  final GlobalKey<FormState> _signInFormKey = GlobalKey();
  final GlobalKey<FormInputState> _emailInputKey = GlobalKey();
  final GlobalKey<FormInputState> _passwordInputKey = GlobalKey();
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
                _buildSignInLabel(),
                const SizedBox(height: 8.0),
                _buildInputForm(),
                const SizedBox(height: 24.0),
                _buildForgotPasswordLink(),
                const SizedBox(height: 16.0),
                _buildSignUpLink(context),
                const SizedBox(height: 32.0),
                _buildSignUpLabel(),
                const SizedBox(height: 24.0),
                _buildSignUpButtons(),
                const SizedBox(height: 24.0),
                _buildLogInButton(context),
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

  Widget _buildSignInLabel() {
    return Text(
      'sign_in.title'.tr(),
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ).poppins,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: <Widget>[
          BlocBuilder<SignInBloc, SignInState>(
            builder: (_, state) {
              return Text(
                state is SignInError ? state.error : '',
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

  Widget _buildForgotPasswordLink() {
    return GestureDetector(
      onTap: () {
        // TODO: navigate to Forgot Password screen
      },
      child: Text(
        'sign_in.forgot_password'.tr(),
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ).poppins,
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
              ..onTap = () {
                Navigator.of(context).pushNamed(AuthRoutes.signUp);
              },
            style: const TextStyle(
              color: AppColors.primaryColor,
            ),
          )
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

  Widget _buildLogInButton(BuildContext context) {
    return Button(
      onPressed: () {
        _login(context);

        if (_signInFormKey.currentState!.validate()) {
          // TODO: successful sign in
        } else {
          // TODO: show error text
        }
      },
      text: 'sign_in.login'.tr(),
    );
  }

  void _login(BuildContext context) {
    final email = _emailInputKey.currentState!.value;
    final password = _passwordInputKey.currentState!.value;

    context.signInBloc.login(
      email: email,
      password: password,
    );
  }
}
