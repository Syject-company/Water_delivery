import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

extension BlocGetter on BuildContext {
  MainBloc get main => this.read<MainBloc>();
}

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(screen: Screen.categories));

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is ChangeScreen) {
      yield* _mapChangeScreenEventToState(event);
    }
  }

  Stream<MainState> _mapChangeScreenEventToState(ChangeScreen event) async* {
    yield state.copyWith(screen: event.screen);
  }
}
