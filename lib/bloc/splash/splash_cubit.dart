import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _checkForFirstLaunch();
  }

  static const Duration _loadingDuration = Duration(seconds: 1);

  void _checkForFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final firstLaunch = prefs.getBool('first_launch') ?? true;

    emit(SplashLoading());
    await Future.delayed(_loadingDuration);

    if (firstLaunch) {
      emit(SplashVideo());
    } else {
      emit(SplashAuth());
    }
  }
}
