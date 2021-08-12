import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/delivery/date.dart';

part 'date_event.dart';
part 'date_state.dart';

extension BlocGetter on BuildContext {
  DeliveryDateBloc get deliveryDate => this.read<DeliveryDateBloc>();
}

class DeliveryDateBloc extends Bloc<DeliveryDateEvent, DeliveryDateState> {
  DeliveryDateBloc() : super(DeliveryDatesLoaded(dates: _dates));

  @override
  Stream<DeliveryDateState> mapEventToState(
    DeliveryDateEvent event,
  ) async* {}
}

final List<DeliveryDate> _dates = [
  DeliveryDate(
    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 8,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1))),
    periods: <Period>[
      Period(
        id: '3',
        startTime: 8,
        endTime: 13,
        available: false,
      ),
      Period(
        id: '4',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 2))),
    periods: <Period>[
      Period(
        id: '5',
        startTime: 8,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '6',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 3))),
    periods: <Period>[
      Period(
        id: '7',
        startTime: 8,
        endTime: 13,
        available: false,
      ),
      Period(
        id: '8',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 4))),
    periods: <Period>[
      Period(
        id: '9',
        startTime: 8,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '10',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 5))),
    periods: <Period>[
      Period(
        id: '11',
        startTime: 8,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '12',
        startTime: 13,
        endTime: 8,
        available: false,
      ),
    ],
  ),
  DeliveryDate(
    date:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 6))),
    periods: <Period>[
      Period(
        id: '13',
        startTime: 8,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '14',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
];
