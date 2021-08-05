import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/auth/auth_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/button/circle_button.dart';
import 'package:water/ui/shared_widgets/input/form_fields.dart';
import 'package:water/ui/shared_widgets/loader_overlay.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/ui/validators/email.dart';
import 'package:water/ui/validators/field.dart';
import 'package:water/ui/validators/password.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
  }

  final GlobalKey<FormState> _signUpFormKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _emailInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _passwordInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _confirmPasswordInputKey =
      GlobalKey<WaterFormInputState>();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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

  Widget _buildCreateAccountLabel() {
    return WaterText(
      'text.create_account'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _signUpFormKey,
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
            hintText: 'input.email'.tr(),
            validator: const EmailValidator().validator,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _passwordInputKey,
            hintText: 'input.password'.tr(),
            validator: const PasswordValidator().validator,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _confirmPasswordInputKey,
            hintText: 'input.confirm_password'.tr(),
            validator:
                const FieldValidator(fieldName: 'Confirm Password').validator,
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
    );
  }

  Widget _buildSignUpButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WaterCircleButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.auth.add(FacebookLogin());
          },
          icon: AppIcons.facebook,
          iconSize: 26.0,
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

  Widget _buildRegisterButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (!_signUpFormKey.currentState!.validate()) {
          return;
        }

        final email = _emailInputKey.currentState!.value;
        final password = _passwordInputKey.currentState!.value;
        final confirmPassword = _confirmPasswordInputKey.currentState!.value;

        context.auth.add(Register(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ));
      },
      text: 'button.register'.tr(),
    );
  }
}
