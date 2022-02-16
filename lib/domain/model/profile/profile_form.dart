import 'package:equatable/equatable.dart';
import 'package:water/domain/model/profile/address_translation_form.dart';

class ProfileFormFields {
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String phoneNumber = 'phoneNumber';
  static const String birthday = 'birthDate';
  static const String familyMembersCount = 'familyMembersCount';
  static const String nationality = 'nationality';
  static const String addressTranslations = 'addressTranslations';
}

class ProfileForm extends Equatable {
  const ProfileForm({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.birthday,
    required this.familyMembersCount,
    required this.nationality,
    required this.addressTranslations,
  });

  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? birthday;
  final int familyMembersCount;
  final String? nationality;
  final List<AddressTranslationForm>? addressTranslations;

  Map<String, dynamic> toJson() {
    return {
      ProfileFormFields.firstName: firstName,
      ProfileFormFields.lastName: lastName,
      ProfileFormFields.phoneNumber: phoneNumber,
      ProfileFormFields.birthday: birthday,
      ProfileFormFields.familyMembersCount: familyMembersCount,
      ProfileFormFields.nationality: nationality,
      ProfileFormFields.addressTranslations: addressTranslations,
    };
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        birthday,
        familyMembersCount,
        nationality,
        addressTranslations,
      ];
}
