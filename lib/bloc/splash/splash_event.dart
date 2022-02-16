part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class PreloadImages extends SplashEvent {
  const PreloadImages();
}

class Loading extends SplashEvent {
  const Loading();
}

class LoadVideo extends SplashEvent {
  const LoadVideo();
}
