import 'package:easy_localization/easy_localization.dart';
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
    required this.startDate,
    required this.endDate,
  });

  final String id;
  final String title;
  final double percent;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  factory Sale.fromJson(Map<String, dynamic> json) {
    final percent = json[SaleFields.percent] / 100;
    final startDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json[SaleFields.startDate]);
    final endDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json[SaleFields.endDate]);

    return Sale(
      id: json[SaleFields.id],
      title: json[SaleFields.title],
      percent: percent,
      description: json[SaleFields.description],
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        percent,
        description,
        startDate,
        endDate,
      ];
}
