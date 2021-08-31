part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

class SaveProfile extends ProfileEvent {
  const SaveProfile({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.birthday,
    required this.familyMembersAmount,
    this.nationality,
    required this.language,
    this.city,
    this.district,
    this.street,
    this.building,
    this.apartment,
    this.floor,
  });

  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final DateTime? birthday;
  final int familyMembersAmount;
  final String? nationality;
  final String language;
  final String? city;
  final String? district;
  final String? street;
  final String? building;
  final String? apartment;
  final String? floor;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        birthday,
        familyMembersAmount,
        nationality,
        city,
        district,
        street,
        building,
        apartment,
        floor,
      ];
}

class ClearProfile extends ProfileEvent {
  const ClearProfile();
}
