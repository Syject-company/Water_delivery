import 'period.dart';

export 'period.dart';
export 'time.dart';

class DeliveryDateFields {
  static const String id = 'id';
  static const String date = 'dateTime';
  static const String available = 'isAvailable';
  static const String periods = 'period';
}

class DeliveryDate {
  const DeliveryDate({
    required this.id,
    required this.date,
    required this.available,
    required this.periods,
  });

  final String id;
  final String date;
  final bool available;
  final List<Period> periods;

  factory DeliveryDate.fromJson(Map<String, dynamic> json) {
    final Iterable iterable = json[DeliveryDateFields.periods];
    final periods = List<Period>.from(iterable.map((json) {
      return Period.fromJson(json);
    }));

    return DeliveryDate(
      id: json[DeliveryDateFields.id] as String,
      date: json[DeliveryDateFields.date] as String,
      available: json[DeliveryDateFields.available] as bool,
      periods: periods,
    );
  }
}
