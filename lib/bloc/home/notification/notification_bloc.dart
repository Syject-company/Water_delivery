import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/notification.dart' as water;

part 'notification_event.dart';
part 'notification_state.dart';

extension BlocGetter on BuildContext {
  NotificationsBloc get notifications => this.read<NotificationsBloc>();
}

class NotificationsBloc extends Bloc<NotificationEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsState(items: _notifications));

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationEvent event,
  ) async* {}
}

final List<water.Notification> _notifications = [
  water.Notification(
    id: '1',
    postedTime: DateTime(2020, 5, 12, 10, 25),
    applicationUserId: '',
    cultureNameId: '',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
  water.Notification(
    id: '2',
    postedTime: DateTime(2020, 5, 15, 12, 34),
    applicationUserId: '',
    cultureNameId: '',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  ),
  water.Notification(
    id: '3',
    postedTime: DateTime(2020, 5, 18, 14, 43),
    applicationUserId: '',
    cultureNameId: '',
    body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
        'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ),
];
