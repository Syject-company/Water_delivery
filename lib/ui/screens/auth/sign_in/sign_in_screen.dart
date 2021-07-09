import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/rounded_button.dart';
import 'package:water/ui/shared_widgets/logo.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                physics: const BouncingScrollPhysics(),
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Logo(),
                    const SizedBox(height: 32.0),
                    Text(
                      'Sign In',
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 21.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 48.0),
                    TextField(
                      cursorColor: AppColors.primaryColor,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: AppColors.primaryTextColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                        const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                          borderSide: BorderSide(
                            color: AppColors.inputDefaultBorderColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.0,
                          ),
                        ),
                        labelStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      cursorColor: AppColors.primaryColor,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: AppColors.primaryTextColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16.0,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                          borderSide: BorderSide(
                            color: AppColors.inputDefaultBorderColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2.0,
                          ),
                        ),
                        labelStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'Forgot your password?',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    RichText(
                      text: TextSpan(
                        text: 'New in?',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Sign up',
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      'Sign up with',
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundedButton(
                          iconPath: 'assets/svg/facebook.svg',
                        ),
                        const SizedBox(width: 18.0),
                        RoundedButton(
                          iconPath: 'assets/svg/google.svg',
                        ),
                        const SizedBox(width: 18.0),
                        RoundedButton(
                          iconPath: 'assets/svg/apple.svg',
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Button(
                      onPressed: () {},
                      text: 'Log In',
                    )
                  ],
                ),
              ),
            ),
            // PreferredSize(
            //   preferredSize: Size(0, kToolbarHeight),
            //   child: AppBar(
            //     backgroundColor: Colors.transparent,
            //     elevation: 1,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
