import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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

const int days = 7;

class DeliveryDatesBloc extends Bloc<DeliveryDatesEvent, DeliveryDatesState> {
  DeliveryDatesBloc()
      : super(
          DeliveryDatesState(
            dates: const [],
          ),
        );

  final PeriodService _periodService = locator<PeriodService>();

  @override
  Stream<DeliveryDatesState> mapEventToState(
    DeliveryDatesEvent event,
  ) async* {
    if (event is LoadDeliveryDates) {
      yield* _mapLoadDeliveryDatesToState();
    }
  }

  Stream<DeliveryDatesState> _mapLoadDeliveryDatesToState() async* {
    final dates = await _periodService.getAll('Al Ain');

    // for (int i = 0; i < days; i++) {
    //   final date = DateTime.now().add(Duration(days: i));
    //   dates.add(
    //     DeliveryDate(
    //       date: DateFormat('yyyy-MM-dd').format(date),
    //       periods: periods.map((period) {
    //         return Period(
    //           id: period.id,
    //           startTime: period.startTime,
    //           endTime: period.endTime,
    //           available: date.weekday != DateTime.friday,
    //         );
    //       }).toList(),
    //     ),
    //   );
    // }

    yield state.copyWith(dates: dates);
  }
}