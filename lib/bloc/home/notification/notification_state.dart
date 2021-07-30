part of 'notification_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    required this.items,
  });

  final List<water.Notification> items;

  NotificationsState copyWith({
    List<water.Notification>? items,
  }) =>
      NotificationsState(
        items: items ?? this.items,
      );

  @override
  List<Object> get props => [items];
}
