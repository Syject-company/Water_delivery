import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/profile/change_password/change_password_bloc.dart';
import 'package:water/ui/screens/home/auth/auth_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/password.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _changePasswordFormKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

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
          homeNavigator.pop();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LoaderOverlay(
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          context.showLoader(state is ChangePasswordLoading);

          if (state is ChangePasswordSuccess) {
            homeNavigator.pop();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          physics: const BouncingScrollPhysics(),
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
                  _buildEnterNewPasswordLabel(),
                  const SizedBox(height: 12.0),
                  _buildInputForm(),
                  const SizedBox(height: 24.0),
                  _buildLogInButton(context),
                ],
              ),
            ),
          ),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        ),
      ),
    );
  }

  Widget _buildEnterNewPasswordLabel() {
    return WaterText(
      'text.change_password'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
    );
  }

  Widget _buildInputForm() {
    return Form(
      key: _changePasswordFormKey,
      child: Column(
        children: [
          BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
            buildWhen: (_, state) {
              return state is ChangePasswordLoading ||
                  state is ChangePasswordError;
            },
            builder: (_, state) {
              return WaterText(
                state is ChangePasswordError ? state.message : '',
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
            controller: _passwordController,
            validator: const PasswordValidator(fieldName: 'Password').validator,
            hintText: 'input.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _newPasswordController,
            validator:
                const PasswordValidator(fieldName: 'New Password').validator,
            hintText: 'input.new_password'.tr(),
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildLogInButton(BuildContext context) {
    return WaterButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();

        if (!_changePasswordFormKey.currentState!.validate()) {
          return;
        }

        final password = _passwordController.text;
        final newPassword = _newPasswordController.text;

        context.changePassword.add(
          ChangePassword(
            password: password,
            newPassword: newPassword,
          ),
        );
      },
      text: 'button.save'.tr(),
    );
  }
}
