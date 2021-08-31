part of 'profile_bloc.dart';

enum ProfileStatus { none, loading, loaded, saving, saved }

class ProfileState extends Equatable {
  const ProfileState({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.birthday,
    this.nationality,
    this.city,
    this.district,
    this.street,
    this.building,
    this.apartment,
    this.floor,
    this.familyMembersCount,
    this.referralCode,
    this.walletBalance,
    this.status = ProfileStatus.none,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthday;
  final String? nationality;
  final String? city;
  final String? district;
  final String? street;
  final String? building;
  final String? apartment;
  final String? floor;
  final int? familyMembersCount;
  final int? referralCode;
  final double? walletBalance;
  final ProfileStatus status;

  ProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    DateTime? birthday,
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
    ProfileStatus? status,
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
        status: status ?? this.status,
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
        status,
      ];
}
