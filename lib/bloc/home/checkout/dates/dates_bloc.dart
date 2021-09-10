import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/delivery/date.dart';
import 'package:water/domain/service/period_service.dart';
import 'package:water/locator.dart';

part 'dates_event.dart';
part 'dates_state.dart';

extension BlocGetter on BuildContext {
  DeliveryDatesBloc get deliveryDates => this.read<DeliveryDatesBloc>();
}

class DeliveryDatesBloc extends Bloc<DeliveryDatesEvent, DeliveryDatesState> {
  DeliveryDatesBloc() : super(DeliveryDatesInitial());

  final PeriodService _periodService = locator<PeriodService>();

  @override
  Stream<DeliveryDatesState> mapEventToState(
    DeliveryDatesEvent event,
  ) async* {
    if (event is LoadDeliveryDates) {
      yield* _mapLoadDeliveryDatesToState(event);
    }
  }

  Stream<DeliveryDatesState> _mapLoadDeliveryDatesToState(
    LoadDeliveryDates event,
  ) async* {
    yield DeliveryDatesLoading();
    final dates = await _periodService.getAll(event.city);
    yield DeliveryDatesLoaded(dates: dates);
  }
}
