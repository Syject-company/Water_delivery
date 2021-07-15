part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class Loading extends SplashEvent {
  const Loading();

  @override
  List<Object> get props => [];
}

class LoadVideo extends SplashEvent {
  const LoadVideo();

  @override
  List<Object> get props => [];
}
