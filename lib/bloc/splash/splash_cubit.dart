import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState(progress: 0.0));

  void simulateFakeProgress() async {
    emit(state.copyWith(progress: state.progress + 0.15));
    await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(progress: state.progress + 0.25));
    await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(progress: state.progress + 0.1));
    await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(progress: state.progress + 0.25));
    await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(progress: state.progress + 0.15));
    await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(progress: state.progress + 0.1));
  }
}
