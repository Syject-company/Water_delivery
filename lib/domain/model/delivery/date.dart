import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import 'period.dart';

export 'period.dart';
export 'time.dart';

class DeliveryDateFields {
  static const String id = 'id';
  static const String date = 'dateTime';
  static const String available = 'isAvailable';
  static const String periods = 'period';
}

class DeliveryDate extends Equatable {
  const DeliveryDate({
    required this.id,
    required this.date,
    required this.available,
    required this.periods,
  });

  final String id;
  final DateTime date;
  final bool available;
  final List<Period> periods;

  factory DeliveryDate.fromJson(Map<String, dynamic> json) {
    final date =
        DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json[DeliveryDateFields.date]);
    final Iterable iterable = json[DeliveryDateFields.periods];
    final periods = List<Period>.from(iterable.map((json) {
      return Period.fromJson(json);
    }));
    periods.sort((a, b) {
      return a.startTime.compareTo(b.startTime);
    });

    return DeliveryDate(
      id: json[DeliveryDateFields.id],
      date: date,
      available: json[DeliveryDateFields.available],
      periods: periods,
    );
  }

  @override
  List<Object> get props => [
        id,
        date,
        available,
        periods,
      ];
}
