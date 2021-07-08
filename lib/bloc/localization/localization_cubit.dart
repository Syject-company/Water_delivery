import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit({required Locale? locale})
      : super(LocalizationState(locale: locale));

  void changeLocale(Locale? locale) {
    emit(state.copyWith(locale: locale));
  }
}
