import 'package:equatable/equatable.dart';

class SaleFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String percent = 'percent';
  static const String description = 'description';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
}

class Sale extends Equatable {
  const Sale({
    required this.id,
    required this.title,
    required this.percent,
    required this.description,
    this.startDate,
    this.endDate,
  });

  final String id;
  final String title;
  final double percent;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;

  Sale.fromJson(Map<String, dynamic> json)
      : this(
          id: json[SaleFields.id] as String,
          title: json[SaleFields.title] as String,
          percent: json[SaleFields.percent] as double,
          description: json[SaleFields.description] as String,
          startDate: json[SaleFields.startDate] as DateTime,
          endDate: json[SaleFields.endDate] as DateTime,
        );

  Map<String, dynamic> toJson() => {
        SaleFields.id: id,
        SaleFields.title: title,
        SaleFields.percent: percent,
        SaleFields.description: description,
        SaleFields.startDate: startDate,
        SaleFields.endDate: endDate,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        percent,
        description,
        startDate,
        endDate,
      ];
}
