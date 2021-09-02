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
  final String? birthday;
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

  Profile.fromJson(Map<String, dynamic> json)
      : this(
          id: json[ProfileFields.id] as String,
          firstName: json[ProfileFields.firstName] as String?,
          lastName: json[ProfileFields.lastName] as String?,
          email: json[ProfileFields.email] as String,
          phoneNumber: json[ProfileFields.phoneNumber] as String?,
          birthday: json[ProfileFields.birthday] as String?,
          familyMembersCount: json[ProfileFields.familyMembersCount] as int,
          nationality: json[ProfileFields.nationality] as String?,
          city: json[ProfileFields.city] as String?,
          district: json[ProfileFields.district] as String?,
          street: json[ProfileFields.street] as String?,
          building: json[ProfileFields.building] as String?,
          apartment: json[ProfileFields.apartment] as String?,
          floor: json[ProfileFields.floor] as String?,
          referralCode: json[ProfileFields.referralCode] as int,
          walletBalance: json[ProfileFields.walletBalance] as double,
        );

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
