import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/auth/forgot_password_form.dart';
import 'package:water/domain/model/auth/new_password_form.dart';
import 'package:water/domain/service/auth_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

extension BlocGetter on BuildContext {
  ForgotPasswordBloc get forgotPassword => this.read<ForgotPasswordBloc>();
}

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordEmailInput());

  final AuthService _authService = locator<AuthService>();

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ResetPassword) {
      yield* _mapResetPasswordToState(event);
    } else if (event is ConfirmNewPassword) {
      yield* _mapConfirmNewPasswordToState(event);
    }
  }

  Stream<ForgotPasswordState> _mapResetPasswordToState(
      ResetPassword event) async* {
    try {
      yield ForgotPasswordLoading();
      await _authService.resetPassword(ForgotPasswordForm(email: event.email));
      yield ForgotPasswordNewPasswordInput(email: event.email);
    } on HttpException catch (e) {
      yield ForgotPasswordError(message: e.message.trim());
    }
  }

  Stream<ForgotPasswordState> _mapConfirmNewPasswordToState(
      ConfirmNewPassword event) async* {
    if (event.password != event.confirmPassword) {
      yield ForgotPasswordError(message: 'Passwords do not equals');
      return;
    }

    if (state is ForgotPasswordNewPasswordInput) {
      final state = this.state as ForgotPasswordNewPasswordInput;

      try {
        yield ForgotPasswordLoading();

        final auth = await _authService.confirmNewPassword(NewPasswordForm(
          email: state.email,
          resetCode: event.code,
          newPassword: event.password,
        ));
        await Session.open(auth: auth);

        yield ForgotPasswordSuccess();
      } on HttpException catch (e) {
        yield ForgotPasswordError(message: e.message.trim());
        yield ForgotPasswordNewPasswordInput(email: state.email);
      }
    }
  }
}
