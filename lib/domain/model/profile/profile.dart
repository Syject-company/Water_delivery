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
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.birthday,
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

  final String id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String? birthday;
  final int? familyMembersCount;
  final String? nationality;
  final String? city;
  final String? district;
  final String? street;
  final String? building;
  final String? apartment;
  final String? floor;
  final int? referralCode;
  final double? walletBalance;

  Profile.fromJson(Map<String, dynamic> json)
      : this(
          id: json[ProfileFields.id] as String,
          firstName: json[ProfileFields.firstName] as String?,
          lastName: json[ProfileFields.lastName] as String?,
          email: json[ProfileFields.email] as String,
          phoneNumber: json[ProfileFields.city] as String?,
          birthday: json[ProfileFields.district] as String?,
          familyMembersCount: json[ProfileFields.floor] as int?,
          nationality: json[ProfileFields.street] as String?,
          city: json[ProfileFields.building] as String?,
          district: json[ProfileFields.apartment] as String?,
          street: json[ProfileFields.floor] as String?,
          building: json[ProfileFields.floor] as String?,
          apartment: json[ProfileFields.floor] as String?,
          floor: json[ProfileFields.floor] as String?,
          referralCode: json[ProfileFields.floor] as int?,
          walletBalance: json[ProfileFields.floor] as double?,
        );

  Map<String, dynamic> toJson() => {
        ProfileFields.id: id,
        ProfileFields.firstName: firstName,
        ProfileFields.lastName: lastName,
        ProfileFields.email: email,
        ProfileFields.phoneNumber: phoneNumber,
        ProfileFields.birthday: birthday,
        ProfileFields.familyMembersCount: familyMembersCount,
        ProfileFields.nationality: nationality,
        ProfileFields.city: city,
        ProfileFields.district: district,
        ProfileFields.street: street,
        ProfileFields.building: building,
        ProfileFields.apartment: apartment,
        ProfileFields.floor: floor,
        ProfileFields.referralCode: referralCode,
        ProfileFields.walletBalance: walletBalance,
      };

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
