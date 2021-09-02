import 'package:equatable/equatable.dart';

class AddressTranslationFormFields {
  static const String language = 'culture';
  static const String city = 'cityName';
  static const String district = 'districtName';
  static const String street = 'street';
  static const String building = 'building';
  static const String apartment = 'apartment';
  static const String floor = 'floor';
}

class AddressTranslationForm extends Equatable {
  const AddressTranslationForm({
    this.language,
    this.city,
    this.district,
    this.street,
    this.building,
    this.apartment,
    this.floor,
  });

  final String? language;
  final String? city;
  final String? district;
  final String? street;
  final String? building;
  final String? apartment;
  final String? floor;

  Map<String, dynamic> toJson() => {
        AddressTranslationFormFields.language: language,
        AddressTranslationFormFields.city: city,
        AddressTranslationFormFields.district: district,
        AddressTranslationFormFields.street: street,
        AddressTranslationFormFields.building: building,
        AddressTranslationFormFields.apartment: apartment,
        AddressTranslationFormFields.floor: floor,
      };

  @override
  List<Object?> get props => [
        language,
        city,
        district,
        street,
        building,
        apartment,
        floor,
      ];
}
