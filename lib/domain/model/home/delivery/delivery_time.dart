import 'period.dart';

export 'period.dart';
export 'selected_time.dart';

class DeliveryTime {
  const DeliveryTime({
    required this.date,
    required this.periods,
  });

  final String date;
  final List<Period> periods;
}
