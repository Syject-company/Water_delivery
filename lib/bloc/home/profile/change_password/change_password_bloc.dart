import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/profile/change_password_form.dart';
import 'package:water/domain/service/account_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

extension BlocGetter on BuildContext {
  ChangePasswordBloc get changePassword => this.read<ChangePasswordBloc>();
}

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial());

  final AccountService _accountService = locator<AccountService>();

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is ChangePassword) {
      yield* _mapChangePasswordToState(event);
    }
  }

  Stream<ChangePasswordState> _mapChangePasswordToState(
    ChangePassword event,
  ) async* {
    if (event.password == event.newPassword) {
      yield ChangePasswordError(message: 'Passwords are equal');
      return;
    }

    if (Session.isAuthenticated) {
      try {
        yield ChangePasswordLoading();

        final form = ChangePasswordForm(
          password: event.password,
          newPassword: event.newPassword,
        );
        await _accountService.changePassword(Session.token!, form);

        yield ChangePasswordSuccess();
      } on HttpException catch (e) {
        yield ChangePasswordError(message: e.message.trim());
      }
    }
  }
}
