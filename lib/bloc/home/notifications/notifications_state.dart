part of 'notifications_bloc.dart';

enum NotificationsStatus { empty, loading, loaded }

class NotificationsState extends Equatable {
  const NotificationsState({
    required this.notifications,
    this.status = NotificationsStatus.empty,
  });

  final List<water.Notification> notifications;
  final NotificationsStatus status;

  NotificationsState copyWith({
    List<water.Notification>? notifications,
    NotificationsStatus? status,
  }) =>
      NotificationsState(
        notifications: notifications ?? this.notifications,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        notifications,
        status,
      ];
}
