import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/domain/model/auth/sign_in_form.dart';
import 'package:water/domain/model/auth/sign_up_form.dart';
import 'package:water/domain/model/auth/token.dart';
import 'package:water/domain/service/auth_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum Social { Facebook, Google, Apple }

extension BlocGetter on BuildContext {
  AuthBloc get auth => this.read<AuthBloc>();
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final AuthService _authService = locator<AuthService>();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Login) {
      yield* _mapLoginToState(event);
    } else if (event is Register) {
      yield* _mapRegisterToState(event);
    } else if (event is FacebookLogin) {
      yield* _mapFacebookLoginToState();
    } else if (event is GoogleLogin) {
      yield* _mapGoogleLoginToState();
    } else if (event is AppleLogin) {
      yield* _mapAppleLoginToState();
    }
  }

  Stream<AuthState> _mapLoginToState(Login event) async* {
    yield const AuthLoading();

    try {
      final auth = await _authService.signIn(
        SignInForm(email: event.email, password: event.password),
      );
      await Session.open(auth: auth);

      yield const AuthSuccess();
    } on HttpException catch (e) {
      yield* _handleAuthError(message: e.message);
    }
  }

  Stream<AuthState> _mapRegisterToState(Register event) async* {
    yield const AuthLoading();

    if (event.password != event.confirmPassword) {
      yield* _handleAuthError(message: 'Passwords do not equals');
      return;
    }

    try {
      final auth = await _authService.signUp(
        SignUpForm(email: event.email, password: event.password),
      );
      await Session.open(auth: auth);

      yield const AuthSuccess();
    } on HttpException catch (e) {
      yield* _handleAuthError(message: e.message);
    }
  }

  Stream<AuthState> _mapFacebookLoginToState() async* {
    yield const AuthLoading();

    final result = await FacebookAuth.instance.login();
    if (result.status != LoginStatus.success) {
      yield* _handleAuthError(message: 'Unable to sign in with Facebook');
      return;
    }

    final token = result.accessToken!.token;
    yield* _signInWith(Social.Facebook, token: token);
  }

  Stream<AuthState> _mapGoogleLoginToState() async* {
    yield const AuthLoading();

    final account = await GoogleSignIn().signIn();
    if (account == null) {
      yield* _handleAuthError(message: 'Unable to sign in with Google');
      return;
    }

    final auth = await account.authentication;
    final token = auth.accessToken!;

    print(auth.accessToken);

    yield* _signInWith(Social.Google, token: token);
  }

  Stream<AuthState> _mapAppleLoginToState() async* {
    try {
      yield const AuthLoading();

      final clientId = 'com.syject.water.glitch';
      final redirectUri =
          'https://gulfa-water.glitch.me/callbacks/sign_in_with_apple';
      final auth = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientId, redirectUri: Uri.parse(redirectUri)),
      );

      print(auth);
      print(auth.identityToken);

      final token = auth.identityToken!;

      yield* _signInWith(Social.Apple, token: token);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        yield* _handleAuthError(message: e.message);
      }
    }
  }

  Stream<AuthState> _signInWith(
    Social social, {
    required String token,
  }) async* {
    try {
      final AuthResponse auth;
      switch (social) {
        case Social.Facebook:
          auth = await _authService.signInWithFacebook(Token(token: token));
          break;
        case Social.Google:
          auth = await _authService.signInWithGoogle(Token(token: token));
          break;
        case Social.Apple:
          auth = await _authService.signInWithApple(Token(token: token));
          break;
      }
      await Session.open(auth: auth);

      yield const AuthSuccess();
    } on HttpException catch (e) {
      yield* _handleAuthError(message: e.message);
    }
  }

  Stream<AuthState> _handleAuthError({required String message}) async* {
    yield AuthError(message: message.trim());
    yield const AuthInitial();
  }
}
