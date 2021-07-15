import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:water/bloc/auth/social/social_auth_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/screens/auth/router.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/loader.dart';
import 'package:water/ui/shared_widgets/logo/animated_logo.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/label.dart';
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

  // showOverlay(BuildContext context) {
  //   final overlay = Overlay.of(context)!;
  //   final entry = OverlayEntry(builder: (_) {
  //     return Positioned(
  //       width: MediaQuery.of(context).size.width,
  //       height: MediaQuery.of(context).size.height,
  //       child: Container(
  //         color: Colors.white70,
  //         child: Center(
  //           child: AnimatedLogo(),
  //         ),
  //       ),
  //     );
  //   });
  //
  //   overlay.insert(entry);
  // }

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
            _buildSignUpButtons(context),
            const SizedBox(height: 24.0),
            _buildLogInButton(context),
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
          BlocBuilder<SignInBloc, SignInState>(
            builder: (_, state) {
              return Label(
                state is SignInError ? state.message : '',
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
      onTap: () {
        Navigator.of(context).pushNamed(AuthRoutes.forgotPassword);
      },
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
              ..onTap = () {
                Navigator.of(context).pushNamed(AuthRoutes.signUp);
              },
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

  Widget _buildLogInButton(BuildContext context) {
    return Button(
      onPressed: () {
        if (!_signInFormKey.currentState!.validate()) {
          // TODO: show error text
          return;
        }

        final email = _emailInputKey.currentState!.value;
        final password = _passwordInputKey.currentState!.value;

        context.signIn.add(Login(
          email: email,
          password: password,
        ));
      },
      text: 'sign_in.login'.tr(),
    );
  }
}
