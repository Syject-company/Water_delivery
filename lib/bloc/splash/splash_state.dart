part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();

  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashState {
  const SplashLoading();

  @override
  List<Object> get props => [];
}

class SplashVideo extends SplashState {
  const SplashVideo({required this.firstLaunch});

  final bool firstLaunch;

  @override
  List<Object> get props => [firstLaunch];
}
