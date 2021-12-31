import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/domain/model/notification.dart' as water;
import 'package:water/domain/services/notification_service.dart';
import 'package:water/locator.dart';
import 'package:water/utils/localization.dart';
import 'package:water/utils/session.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

extension BlocGetter on BuildContext {
  NotificationsBloc get notifications => this.read<NotificationsBloc>();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({required AuthBloc auth})
      : super(
          NotificationsState(
            notifications: const [],
          ),
        ) {
    _authStateSubscription = auth.stream.listen((state) {
      if (state is Authenticated) {
        final language = Localization.loadLocale().languageCode;
        add(LoadNotifications(language: language));
      } else if (state is Unauthenticated) {
        add(ClearNotifications());
      }
    });
  }

  final NotificationService _notificationService =
      locator<NotificationService>();

  late final StreamSubscription _authStateSubscription;

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is LoadNotifications) {
      yield* _mapLoadNotificationsToState(event);
    } else if (event is ClearNotifications) {
      yield* _mapClearNotificationsToState();
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }

  Stream<NotificationsState> _mapLoadNotificationsToState(
    LoadNotifications event,
  ) async* {
    if (Session.isAuthenticated) {
      print('load notifications');

      yield state.copyWith(status: NotificationsStatus.loading);

      final notifications = await _notificationService.getAll(
        Session.token!,
        event.language,
      );
      notifications.sort((a, b) {
        return b.postedDate.compareTo(a.postedDate);
      });

      yield state.copyWith(
        notifications: notifications.where((notification) {
          return notification.body != null && notification.body!.isNotEmpty;
        }).toList(growable: false),
        status: NotificationsStatus.loaded,
      );
    }
  }

  Stream<NotificationsState> _mapClearNotificationsToState() async* {
    yield state.copyWith(
      notifications: const [],
      status: NotificationsStatus.empty,
    );
  }
}
