part of 'splash_cubit.dart';

@immutable
class SplashState extends Equatable {
  SplashState({required this.progress});

  final double progress;

  SplashState copyWith({double? progress}) {
    return SplashState(
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [progress];
}
