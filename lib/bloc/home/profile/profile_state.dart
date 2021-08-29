part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.firstName,
    this.lastName,
    required this.email,
    this.phoneNumber,
    this.birthday,
    this.nationality,
    this.city,
    this.district,
    this.street,
    this.building,
    this.apartment,
    this.floor,
    required this.familyMembersCount,
    required this.referralCode,
    required this.walletBalance,
  });

  final String? firstName;
  final String? lastName;
  final String email;
  final String? phoneNumber;
  final String? birthday;
  final String? nationality;
  final String? city;
  final String? district;
  final String? street;
  final String? building;
  final String? apartment;
  final String? floor;
  final int familyMembersCount;
  final int referralCode;
  final double walletBalance;

  ProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? birthday,
    String? nationality,
    String? city,
    String? district,
    String? street,
    String? building,
    String? apartment,
    String? floor,
    int? familyMembersCount,
    int? referralCode,
    double? walletBalance,
  }) =>
      ProfileState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        birthday: birthday ?? this.birthday,
        nationality: nationality ?? this.nationality,
        city: city ?? this.city,
        district: district ?? this.district,
        street: street ?? this.street,
        building: building ?? this.building,
        apartment: apartment ?? this.apartment,
        floor: floor ?? this.floor,
        familyMembersCount: familyMembersCount ?? this.familyMembersCount,
        referralCode: referralCode ?? this.referralCode,
        walletBalance: walletBalance ?? this.walletBalance,
      );

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        birthday,
        nationality,
        city,
        district,
        street,
        building,
        apartment,
        floor,
        familyMembersCount,
        referralCode,
        walletBalance,
      ];
}
