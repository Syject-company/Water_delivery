import 'package:equatable/equatable.dart';

class NotificationFields {
  static const String id = 'id';
  static const String postedTime = 'postedTime';
  static const String applicationUserId = 'applicationUserId';
  static const String cultureNameId = 'cultureNameId';
  static const String body = 'body';
}

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.postedTime,
    required this.applicationUserId,
    required this.cultureNameId,
    required this.body,
  });

  final String id;
  final DateTime postedTime;
  final String applicationUserId;
  final String cultureNameId;
  final String body;

  Notification.fromJson(Map<String, dynamic> json)
      : this(
          id: json[NotificationFields.id] as String,
          postedTime: json[NotificationFields.postedTime] as DateTime,
          applicationUserId:
              json[NotificationFields.applicationUserId] as String,
          cultureNameId: json[NotificationFields.cultureNameId] as String,
          body: json[NotificationFields.body] as String,
        );

  Map<String, dynamic> toJson() => {
        NotificationFields.id: id,
        NotificationFields.postedTime: postedTime,
        NotificationFields.applicationUserId: applicationUserId,
        NotificationFields.cultureNameId: cultureNameId,
        NotificationFields.body: body,
      };

  @override
  List<Object> get props => [
        id,
        postedTime,
        applicationUserId,
        cultureNameId,
        body,
      ];
}
