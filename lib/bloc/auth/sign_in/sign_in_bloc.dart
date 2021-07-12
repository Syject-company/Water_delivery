import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water/domain/model/auth/sign_in_form.dart';
import 'package:water/domain/repository/user_repository.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial());

  final UserRepository _userRepository = locator<UserRepository>();

  void login({required String email, required String password}) {
    add(Login(email: email, password: password));
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is Login) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<SignInState> _mapLoginToState(Login event) async* {
    yield SignInInitial();

    try {
      final response = await _userRepository
          .signIn(SignInForm(email: 'test@test.com', password: '12345678q'));
      await Session.open(token: response.token, userId: response.id);
      print(Session.token);
      print(Session.userId);
      print(Session.isActive);
      yield SignInSuccess();
    } catch (e) {
      if (e is HttpException) {
        yield SignInError(error: e.message);
      }
    }
  }
}
