import 'package:easy_localization/easy_localization.dart';
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
  final DateTime postedDate;
  final String applicationUserId;
  final String cultureNameId;
  final String? body;

  factory Notification.fromJson(Map<String, dynamic> json) {
    final postedDate = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .parse(json[NotificationFields.postedDate]);

    return Notification(
      id: json[NotificationFields.id],
      postedDate: postedDate,
      applicationUserId: json[NotificationFields.applicationUserId],
      cultureNameId: json[NotificationFields.cultureNameId],
      body: json[NotificationFields.body],
    );
  }

  @override
  List<Object?> get props => [
        id,
        postedDate,
        applicationUserId,
        cultureNameId,
        body,
      ];
}
