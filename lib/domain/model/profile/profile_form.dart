import 'package:equatable/equatable.dart';

class ProfileFormFields {
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String phoneNumber = 'phoneNumber';
  static const String birthDate = 'birthDate';
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

class ProfileForm extends Equatable {
  const ProfileForm({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.familyMembersCount,
    required this.nationality,
    required this.city,
    required this.district,
    required this.street,
    required this.building,
    required this.apartment,
    required this.floor,
    required this.referralCode,
    required this.walletBalance,
  });

  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String birthDate;
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

  ProfileForm.fromJson(Map<String, dynamic> json)
      : this(
          firstName: json[ProfileFormFields.firstName] as String,
          lastName: json[ProfileFormFields.lastName] as String,
          email: json[ProfileFormFields.email] as String,
          phoneNumber: json[ProfileFormFields.city] as String,
          birthDate: json[ProfileFormFields.district] as String,
          familyMembersCount: json[ProfileFormFields.floor] as int,
          nationality: json[ProfileFormFields.street] as String,
          city: json[ProfileFormFields.building] as String,
          district: json[ProfileFormFields.apartment] as String,
          street: json[ProfileFormFields.floor] as String,
          building: json[ProfileFormFields.floor] as String,
          apartment: json[ProfileFormFields.floor] as String,
          floor: json[ProfileFormFields.floor] as String,
          referralCode: json[ProfileFormFields.floor] as int,
          walletBalance: json[ProfileFormFields.floor] as double,
        );

  Map<String, dynamic> toJson() => {
        ProfileFormFields.firstName: firstName,
        ProfileFormFields.lastName: lastName,
        ProfileFormFields.email: email,
        ProfileFormFields.phoneNumber: phoneNumber,
        ProfileFormFields.birthDate: birthDate,
        ProfileFormFields.familyMembersCount: familyMembersCount,
        ProfileFormFields.nationality: nationality,
        ProfileFormFields.city: city,
        ProfileFormFields.district: district,
        ProfileFormFields.street: street,
        ProfileFormFields.building: building,
        ProfileFormFields.apartment: apartment,
        ProfileFormFields.floor: floor,
        ProfileFormFields.referralCode: referralCode,
        ProfileFormFields.walletBalance: walletBalance,
      };

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        birthDate,
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
