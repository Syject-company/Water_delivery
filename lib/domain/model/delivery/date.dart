import 'period.dart';

export 'period.dart';
export 'time.dart';

class DeliveryDate {
  const DeliveryDate({
    required this.date,
    required this.periods,
  });

  final String date;
  final List<Period> periods;
}
