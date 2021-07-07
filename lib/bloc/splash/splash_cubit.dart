import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  static const Duration _loadingDuration = Duration(seconds: 1);

  SplashCubit() : super(SplashInitial());

  void startLoading() async {
    emit(SplashLoading());
    await Future.delayed(_loadingDuration);
    emit(SplashVideo());
  }
}
