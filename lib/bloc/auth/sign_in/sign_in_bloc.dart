import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/auth/sign_in_form.dart';
import 'package:water/domain/service/auth_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

extension BlocGetter on BuildContext {
  SignInBloc get signIn => this.read<SignInBloc>();
}

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInInitial());

  final AuthService _authService = locator<AuthService>();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is Login) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<SignInState> _mapLoginToState(Login event) async* {
    yield const SignInLoading();

    try {
      final auth = await _authService.signIn(SignInForm(
        email: event.email,
        password: event.password,
      ));
      await Session.open(token: auth.token, userId: auth.id);
      print(Session.token);
      print(Session.userId);
      print(Session.isActive);

      yield const SignInSuccess();
    } on HttpException catch (e) {
      yield SignInError(message: e.message.trim());
      yield const SignInInitial();
    }
  }
}
