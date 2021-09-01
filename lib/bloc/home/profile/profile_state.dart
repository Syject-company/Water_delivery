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
    required this.familyMembersCount,
    required this.referralCode,
    required this.walletBalance,
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
  final int familyMembersCount;
  final int referralCode;
  final double walletBalance;
  final ProfileStatus status;

  ProfileState copyWith({
    Nullable<String>? firstName,
    Nullable<String>? lastName,
    Nullable<String>? email,
    Nullable<String>? phoneNumber,
    Nullable<DateTime>? birthday,
    Nullable<String>? nationality,
    Nullable<String>? city,
    Nullable<String>? district,
    Nullable<String>? street,
    Nullable<String>? building,
    Nullable<String>? apartment,
    Nullable<String>? floor,
    int? familyMembersCount,
    int? referralCode,
    double? walletBalance,
    ProfileStatus? status,
  }) =>
      ProfileState(
        firstName: firstName != null ? firstName.value : this.firstName,
        lastName: lastName != null ? lastName.value : this.lastName,
        email: email != null ? email.value : this.email,
        phoneNumber: phoneNumber != null ? phoneNumber.value : this.phoneNumber,
        birthday: birthday != null ? birthday.value : this.birthday,
        nationality: nationality != null ? nationality.value : this.nationality,
        city: city != null ? city.value : this.city,
        district: district != null ? district.value : this.district,
        street: street != null ? street.value : this.street,
        building: building != null ? building.value : this.building,
        apartment: apartment != null ? apartment.value : this.apartment,
        floor: floor != null ? floor.value : this.floor,
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
