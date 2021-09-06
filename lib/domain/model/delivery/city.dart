import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City(
    this.name, {
    required this.districts,
  });

  final String name;
  final List<String> districts;

  @override
  List<Object> get props => [
        name,
        districts,
      ];
}
