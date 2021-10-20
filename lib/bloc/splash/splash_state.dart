part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class ImagesPreloaded extends SplashState {
  const ImagesPreloaded({required this.images});

  final List<String> images;

  @override
  List<Object> get props => [images];
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashVideo extends SplashState {
  const SplashVideo({required this.firstLaunch});

  final bool firstLaunch;

  @override
  List<Object> get props => [firstLaunch];
}

class SplashError extends SplashState {
  const SplashError();
}
