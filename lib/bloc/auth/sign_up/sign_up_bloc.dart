import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/auth/sign_up_form.dart';
import 'package:water/domain/service/auth_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

extension BlocGetter on BuildContext {
  SignUpBloc get signUp => this.read<SignUpBloc>();
}

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpInitial());

  final AuthService _authService = locator<AuthService>();

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is Register) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<SignUpState> _mapRegisterToState(Register event) async* {
    yield const SignUpLoading();

    if (event.password != event.confirmPassword) {
      yield const SignUpError(message: 'Passwords do not equals');
      return;
    }

    try {
      final auth = await _authService.signUp(
        SignUpForm(email: event.email, password: event.password),
      );

      await Session.open(token: auth.token, userId: auth.id);
      print(Session.token);
      print(Session.userId);
      print(Session.isActive);

      yield const SignUpSuccess();
    } on HttpException catch (e) {
      yield SignUpError(message: e.message.trim());
      yield const SignUpInitial();
    }
  }
}
