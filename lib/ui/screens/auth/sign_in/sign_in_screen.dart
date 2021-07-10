import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/appbar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/logo.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

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
                const SizedBox(height: 48.0),
                _buildInputForm(),
                const SizedBox(height: 24.0),
                _buildForgotPasswordLink(),
                const SizedBox(height: 16.0),
                _buildSignUpLink(),
                const SizedBox(height: 32.0),
                _buildSignUpLabel(),
                const SizedBox(height: 32.0),
                _buildSignUpButtons(),
                const SizedBox(height: 32.0),
                _buildLogInButton(),
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
      'Sign In',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    final emailPattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return Form(
      child: Column(
        children: <Widget>[
          FormInput(
            validator: (value) {
              if (value != null && !emailPattern.hasMatch(value)) {
                return 'Wrong email address';
              }
              return null;
            },
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Wrong password';
              }
              return null;
            },
            labelText: 'Password',
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
        'Forgot your password?',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return RichText(
      text: TextSpan(
        text: 'New in?',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: AppColors.secondaryTextColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' Sign up',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: navigate to Sign Up screen
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
      'Sign up with',
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
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

  Widget _buildLogInButton() {
    return Button(
      onPressed: () {},
      text: 'Log In',
    );
  }
}
