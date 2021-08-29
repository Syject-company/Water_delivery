import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/notification.dart' as water;
import 'package:water/domain/service/notification_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

extension BlocGetter on BuildContext {
  NotificationsBloc get notifications => this.read<NotificationsBloc>();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial());

  final NotificationService _notificationService =
      locator<NotificationService>();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is LoadNotifications) {
      yield* _mapLoadNotificationsToState();
    }
  }

  Stream<NotificationsState> _mapLoadNotificationsToState() async* {
    if (Session.isAuthenticated) {
      yield NotificationsLoading();
      final notifications = await _notificationService.getAll(Session.token!);
      yield NotificationsLoaded(notifications: notifications);
    }
  }
}
