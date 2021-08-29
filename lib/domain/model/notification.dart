import 'package:equatable/equatable.dart';

class NotificationFields {
  static const String id = 'id';
  static const String postedDate = 'postedTime';
  static const String applicationUserId = 'applicationUserId';
  static const String cultureNameId = 'cultureNameId';
  static const String body = 'body';
}

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.postedDate,
    required this.applicationUserId,
    required this.cultureNameId,
    required this.body,
  });

  final String id;
  final String postedDate;
  final String applicationUserId;
  final String cultureNameId;
  final String body;

  Notification.fromJson(Map<String, dynamic> json)
      : this(
          id: json[NotificationFields.id] as String,
          postedDate: json[NotificationFields.postedDate] as String,
          applicationUserId:
              json[NotificationFields.applicationUserId] as String,
          cultureNameId: json[NotificationFields.cultureNameId] as String,
          body: json[NotificationFields.body] as String,
        );

  Map<String, dynamic> toJson() => {
        NotificationFields.id: id,
        NotificationFields.postedDate: postedDate,
        NotificationFields.applicationUserId: applicationUserId,
        NotificationFields.cultureNameId: cultureNameId,
        NotificationFields.body: body,
      };

  @override
  List<Object> get props => [
        id,
        postedDate,
        applicationUserId,
        cultureNameId,
        body,
      ];
}
