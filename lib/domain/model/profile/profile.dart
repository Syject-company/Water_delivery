import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class ProfileFields {
  static const String id = 'id';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String phoneNumber = 'phoneNumber';
  static const String birthday = 'birthDate';
  static const String familyMembersCount = 'familyMembersCount';
  static const String nationality = 'nationality';
  static const String city = 'cityName';
  static const String district = 'districtName';
  static const String street = 'street';
  static const String building = 'building';
  static const String apartment = 'apartment';
  static const String floor = 'floor';
  static const String referralCode = 'referralCode';
  static const String walletBalance = 'walletBalance';
}

class Profile extends Equatable {
  const Profile({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    this.phoneNumber,
    this.birthday,
    required this.familyMembersCount,
    this.nationality,
    this.city,
    this.district,
    this.street,
    this.building,
    this.apartment,
    this.floor,
    required this.referralCode,
    required this.walletBalance,
  });

  final String id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final DateTime? birthday;
  final int familyMembersCount;
  final String? nationality;
  final String? city;
  final String? district;
  final String? street;
  final String? building;
  final String? apartment;
  final String? floor;
  final int referralCode;
  final double walletBalance;

  factory Profile.fromJson(Map<String, dynamic> json) {
    DateTime? birthday;
    if (json[ProfileFields.birthday] != null) {
      birthday =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json[ProfileFields.birthday]);
    }

    return Profile(
      id: json[ProfileFields.id],
      firstName: json[ProfileFields.firstName],
      lastName: json[ProfileFields.lastName],
      email: json[ProfileFields.email],
      phoneNumber: json[ProfileFields.phoneNumber],
      birthday: birthday,
      familyMembersCount: json[ProfileFields.familyMembersCount],
      nationality: json[ProfileFields.nationality],
      city: json[ProfileFields.city],
      district: json[ProfileFields.district],
      street: json[ProfileFields.street],
      building: json[ProfileFields.building],
      apartment: json[ProfileFields.apartment],
      floor: json[ProfileFields.floor],
      referralCode: json[ProfileFields.referralCode],
      walletBalance: json[ProfileFields.walletBalance],
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        birthday,
        familyMembersCount,
        nationality,
        city,
        district,
        street,
        building,
        apartment,
        floor,
        referralCode,
        walletBalance,
      ];
}
