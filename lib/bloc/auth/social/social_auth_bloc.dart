import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water/domain/model/auth/auth_response.dart';
import 'package:water/domain/model/auth/token.dart';
import 'package:water/domain/service/auth_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'social_auth_event.dart';
part 'social_auth_state.dart';

enum Social { Facebook, Google, Apple }

extension BlocGetter on BuildContext {
  SocialAuthBloc get socialAuth => this.read<SocialAuthBloc>();
}

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  SocialAuthBloc() : super(SocialAuthInitial());

  final AuthService _authService = locator<AuthService>();

  @override
  Stream<SocialAuthState> mapEventToState(
    SocialAuthEvent event,
  ) async* {
    if (event is SignInWithFacebook) {
      yield* _mapSignInWithFacebookToState();
    } else if (event is SignInWithGoogle) {
      yield* _mapSignInWithGoogleToState();
    } else if (event is SignInWithApple) {
      yield* _mapSignInWithAppleToState();
    }
  }

  Stream<SocialAuthState> _mapSignInWithFacebookToState() async* {
    yield const SocialAuthLoading();

    final result = await FacebookAuth.instance.login();
    if (result.status != LoginStatus.success) {
      yield const SocialAuthError(message: 'Unable to sign in with Facebook');
      return;
    }

    final token = result.accessToken!.token;
    yield* _signInWithSocial(Social.Facebook, token: token);
  }

  Stream<SocialAuthState> _mapSignInWithGoogleToState() async* {
    yield const SocialAuthLoading();

    final account = await GoogleSignIn().signIn();
    if (account == null) {
      yield const SocialAuthError(message: 'Unable to sign in with Google');
      return;
    }

    final auth = await account.authentication;
    final token = auth.accessToken!;

    print(auth.accessToken);

    yield* _signInWithSocial(Social.Google, token: token);
    await GoogleSignIn().signOut();
  }

  Stream<SocialAuthState> _mapSignInWithAppleToState() async* {
    yield const SocialAuthError(message: 'Unable to sign in with Apple');
    // TODO: implement apple sign in
  }

  Stream<SocialAuthState> _signInWithSocial(
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
      await Session.open(token: auth.token, userId: auth.id);
      yield const SocialAuthSuccess();
    } on HttpException catch (e) {
      yield SocialAuthError(message: e.message);
    }
  }
}
