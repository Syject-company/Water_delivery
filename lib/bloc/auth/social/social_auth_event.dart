part of 'social_auth_bloc.dart';

abstract class SocialAuthEvent extends Equatable {
  const SocialAuthEvent();
}

class SignInWithFacebook extends SocialAuthEvent {
  const SignInWithFacebook();

  @override
  List<Object> get props => [];
}

class SignInWithGoogle extends SocialAuthEvent {
  const SignInWithGoogle();

  @override
  List<Object> get props => [];
}

class SignInWithApple extends SocialAuthEvent {
  const SignInWithApple();

  @override
  List<Object> get props => [];
}