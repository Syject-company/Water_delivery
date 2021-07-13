import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:water/util/local_storage.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _checkForFirstLaunch();
  }

  static const Duration _loadingDuration = Duration(seconds: 1);

  void _checkForFirstLaunch() async {
    final firstLaunch = LocalStorage.firstLaunch ?? true;

    emit(SplashLoading());
    await Future.delayed(_loadingDuration);

    if (firstLaunch) {
      emit(SplashVideo());
    } else {
      emit(SplashAuth());
    }
  }
}
