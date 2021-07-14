import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/domain/model/auth/sign_in_form.dart';
import 'package:water/domain/model/auth/sign_up_form.dart';
import 'package:water/domain/service/auth_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'auth_state.dart';

enum Social { Facebook, Google, Apple }

extension BlocGetter on BuildContext {
  AuthCubit get authCubit => this.read<AuthCubit>();
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthService _userService = locator<AuthService>();

  void signUp(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    emit(AuthInitial());

    if (password != confirmPassword) {
      emit(AuthError(error: 'Passwords do not equals'));
    } else {
      try {
        await _userService.signUp(
          SignUpForm(
            email: 'test@test.com',
            password: '1234q',
            phoneNumber: '123456789',
          ),
        );
        emit(AuthSuccess());
      } catch (e) {
        if (e is HttpException) {
          emit(AuthError(error: e.message));
        }
      }
    }
  }

  void signIn({required String email, required String password}) async {
    emit(AuthInitial());

    try {
      final response = await _userService
          .signIn(SignInForm(email: 'test@test.com', password: '12345678q'));
      await Session.open(token: response.token, userId: response.id);
      print(Session.token);
      print(Session.userId);
      print(Session.isActive);

      emit(AuthSuccess());
    } catch (e) {
      if (e is HttpException) {
        emit(AuthError(error: e.message));
      }
    }
  }

  void signInWithFacebook() async {
    final result = await FacebookAuth.instance.login();

    print(result.status);
    print(result.message);
    print(result.accessToken!.token);
    print(result.accessToken!.expires);

    if (result.status == LoginStatus.success) {
      final token = result.accessToken!.token;
      await _signInWithSocial(Social.Facebook, token: token);
    }
  }

  void signInWithGoogle() async {
    final account = await GoogleSignIn().signIn();
    if (account == null) return;

    final auth = await account.authentication;
    final token = auth.accessToken!;

    print(auth.serverAuthCode);
    print(auth.accessToken);

    await _signInWithSocial(Social.Google, token: token);
    await GoogleSignIn().signOut();
  }

  void signInWithApple() {
    // TODO: implement
  }

  Future<void> _signInWithSocial(
    Social social, {
    required String token,
  }) async {
    try {
      final AuthResponse response;

      switch (social) {
        case Social.Facebook:
          response = await _userService.signInWithFacebook(token);
          break;
        case Social.Google:
          response = await _userService.signInWithGoogle(token);
          break;
        case Social.Apple:
          response = await _userService.signInWithApple(token);
          break;
      }
      // await Session.open(token: response.token, userId: response.id);
    } catch (e) {
      if (e is HttpException) {
        emit(AuthError(error: e.message));
      }
    }
  }
}
