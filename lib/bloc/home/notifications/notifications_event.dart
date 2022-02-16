part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationsEvent {
  const LoadNotifications({required this.language});

  final String language;

  @override
  List<Object> get props => [language];
}

class ClearNotifications extends NotificationsEvent {
  const ClearNotifications();
}
