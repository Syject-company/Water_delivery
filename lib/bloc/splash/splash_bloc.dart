import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:water/util/local_storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

const Duration _loadingDuration = Duration(milliseconds: 1500);

extension BlocGetter on BuildContext {
  SplashBloc get splash => this.read<SplashBloc>();
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is Loading) {
      yield* _mapLoadingToState();
    } else if (event is LoadVideo) {
      yield* _mapLoadVideoToState();
    }
  }

  Stream<SplashState> _mapLoadingToState() async* {
    await Future.delayed(_loadingDuration);
    yield SplashLoading();
  }

  Stream<SplashState> _mapLoadVideoToState() async* {
    final firstLaunch = LocalStorage.firstLaunch ?? true;
    yield SplashVideo(firstLaunch: firstLaunch);
  }
}
