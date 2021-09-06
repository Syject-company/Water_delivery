import 'package:equatable/equatable.dart';

class PeriodFields {
  static const String id = 'id';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
}

class Period extends Equatable {
  const Period({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final int startTime;
  final int endTime;

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      id: json[PeriodFields.id],
      startTime: json[PeriodFields.startTime],
      endTime: json[PeriodFields.endTime],
    );
  }

  @override
  List<Object> get props => [
        id,
        startTime,
        endTime,
      ];
}
