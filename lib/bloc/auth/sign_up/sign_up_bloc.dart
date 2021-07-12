import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water/domain/model/auth/sign_up_form.dart';
import 'package:water/domain/repository/user_repository.dart';
import 'package:water/locator.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  final UserRepository _userRepository = locator<UserRepository>();

  void register(
      {required String email,
      required String password,
      required String confirmPassword}) {
    add(Register(
        email: email, password: password, confirmPassword: confirmPassword));
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is Register) {
      yield* _mapRegisterToState(event);
    }
  }

  Stream<SignUpState> _mapRegisterToState(Register event) async* {
    yield SignUpInitial();

    if (event.password != event.confirmPassword) {
      yield SignUpError(error: 'Passwords do not equals');
    } else {
      try {
        await _userRepository.signUp(
          SignUpForm(
            email: 'test@test.com',
            password: '1234q',
            phoneNumber: '123456789',
          ),
        );
        yield SignUpSuccess();
      } catch (e) {
        if (e is HttpException) {
          yield SignUpError(error: e.message);
        }
      }
    }
  }
}
