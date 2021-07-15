part of 'social_auth_bloc.dart';

abstract class SocialAuthState extends Equatable {
  const SocialAuthState();
}

class SocialAuthInitial extends SocialAuthState {
  const SocialAuthInitial();

  @override
  List<Object> get props => [];
}

class SocialAuthLoading extends SocialAuthState {
  const SocialAuthLoading();

  @override
  List<Object> get props => [];
}

class SocialAuthSuccess extends SocialAuthState {
  const SocialAuthSuccess();

  @override
  List<Object> get props => [];
}

class SocialAuthError extends SocialAuthState {
  const SocialAuthError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
