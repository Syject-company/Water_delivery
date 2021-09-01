import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/delivery/date.dart';

part 'dates_event.dart';
part 'dates_state.dart';

extension BlocGetter on BuildContext {
  DeliveryDatesBloc get deliveryDates => this.read<DeliveryDatesBloc>();
}

class DeliveryDatesBloc extends Bloc<DeliveryDatesEvent, DeliveryDatesState> {
  DeliveryDatesBloc()
      : super(
          DeliveryDatesState(
            dates: _dates,
          ),
        );

  @override
  Stream<DeliveryDatesState> mapEventToState(
    DeliveryDatesEvent event,
  ) async* {}
}

final List<DeliveryDate> _dates = [
  DeliveryDate(
    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 7,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 19,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1))),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 7,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 19,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 2))),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 7,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 19,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 3))),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 7,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 19,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 4))),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 7,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 19,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 5))),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 7,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 19,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 6))),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 7,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 19,
        available: true,
      ),
    ],
  ),
];
