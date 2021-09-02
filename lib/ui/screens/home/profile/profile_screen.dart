import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/domain/model/data/cities.dart';
import 'package:water/domain/model/data/nationalities.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final GlobalKey<WaterFormDatePickerState> _birthdayDatePickerKey =
      GlobalKey();
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();
  final GlobalKey<WaterNumberPickerState> _familyMembersPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.saving) {
            context.showLoader(true);
          } else if (state.status == ProfileStatus.saved) {
            context.showLoader(false);
          }
        },
        buildWhen: (_, state) {
          return state.status == ProfileStatus.none ||
              state.status == ProfileStatus.loaded ||
              state.status == ProfileStatus.saved;
        },
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            context.showLoader(true);
          } else if (state.status == ProfileStatus.loaded) {
            context.showLoader(false);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLanguageText(),
                const SizedBox(height: 24.0),
                _buildLanguagePicker(context),
                const SizedBox(height: 24.0),
                _buildUserInputForm(context, state),
                const SizedBox(height: 24.0),
                _buildDeliveryInputForm(state),
                const SizedBox(height: 24.0),
                _buildFamilyMembersPicker(state),
                const SizedBox(height: 24.0),
                _buildSaveButton(),
                const SizedBox(height: 16.0),
                _buildChangePasswordButton(),
                const SizedBox(height: 16.0),
                _buildLogOutButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguageText() {
    return WaterText(
      'text.language'.tr(),
      fontSize: 18.0,
      lineHeight: 1.75,
    ).withPadding(24.0, 0.0, 0.0, 0.0);
  }

  Widget _buildLanguagePicker(BuildContext context) {
    return WaterRadioGroup<Locale>(
      onChanged: (locale) {
        Localization.changeLocale(context, locale);
      },
      initialValue: Localization.currentLocale(context),
      values: {
        const Locale('en'): 'English',
        const Locale('ar'): 'العربية',
      },
      axis: Axis.horizontal,
      spaceBetween: 0.0,
      labelFontSize: 15.0,
      labelLineHeight: 1.25,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ).withPadding(48.0, 0.0, 48.0, 0.0);
  }

  Widget _buildUserInputForm(
    BuildContext context,
    ProfileState state,
  ) {
    _firstNameController.text = state.firstName ?? '';
    _lastNameController.text = state.lastName ?? '';
    _emailController.text = state.email ?? '';
    _phoneNumberController.text = state.phoneNumber ?? '';
    String? formattedBirthday;
    if (state.birthday != null) {
      formattedBirthday = DateFormat.yMMMMd().format(state.birthday!);
    }
    _birthdayController.text = formattedBirthday ?? '';
    _nationalityController.text = state.nationality ?? '';

    return Form(
      child: Column(
        children: [
          WaterFormInput(
            controller: _firstNameController,
            hintText: 'input.first_name'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _lastNameController,
            hintText: 'input.last_name'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _emailController,
            hintText: 'input.email'.tr(),
            readOnly: true,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _phoneNumberController,
            hintText: '00971544400611',
            prefixIcon: Icon(
              AppIcons.phone,
              size: 32.0,
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16.0),
          WaterFormDatePicker(
            key: _birthdayDatePickerKey,
            controller: _birthdayController,
            format: DateFormat.yMMMMd(),
            hintText: 'input.birthday'.tr(),
            helpText: 'input.select_birthday_date'.tr(),
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect(
            controller: _nationalityController,
            hintText: 'input.nationality'.tr(),
            helpText: 'input.select_nationality'.tr(),
            items: nationalities,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInputForm(ProfileState state) {
    _cityController.text = state.city ?? '';
    _districtController.text = state.district ?? '';
    _districtSelectKey.currentState?.setItems(
      cities.firstWhereOrNull((city) {
            return city.name == state.city;
          })?.districts ??
          [],
      reset: false,
    );
    _streetController.text = state.street ?? '';
    _buildingController.text = state.building ?? '';
    _floorController.text = state.floor ?? '';
    _apartmentController.text = state.apartment ?? '';

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WaterText(
            'text.delivery_address'.tr(),
            fontSize: 18.0,
            lineHeight: 1.75,
          ).withPadding(24.0, 0.0, 0.0, 0.0),
          const SizedBox(height: 24.0),
          WaterFormSelect(
            controller: _cityController,
            hintText: 'input.select_emirate'.tr(),
            helpText: 'input.select_emirate'.tr(),
            onChanged: (value) {
              _districtSelectKey.currentState!.setItems(
                cities.firstWhereOrNull((city) {
                      return city.name == value;
                    })?.districts ??
                    [],
              );
            },
            items: cities.map((city) => city.name).toList(),
            enableSearch: false,
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect(
            key: _districtSelectKey,
            controller: _districtController,
            hintText: 'input.select_district'.tr(),
            helpText: 'input.select_district'.tr(),
            items: cities.firstWhereOrNull((city) {
                  return city.name == _cityController.text;
                })?.districts ??
                [],
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _streetController,
            hintText: 'input.street'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _buildingController,
            hintText: 'input.building'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _floorController,
            hintText: 'input.floor'.tr(),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _apartmentController,
            hintText: 'input.apartment'.tr(),
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyMembersPicker(ProfileState state) {
    int familyMembersAmount = state.familyMembersCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: WaterText(
            'text.family_members'.tr(),
            fontSize: 18.0,
            lineHeight: 1.5,
          ).withPadding(24.0, 0.0, 0.0, 0.0),
        ),
        WaterNumberPicker(
          key: _familyMembersPickerKey,
          value: familyMembersAmount,
          maxWidth: 144.0,
          minValue: 0,
        ).withPadding(0.0, 0.0, 12.0, 0.0),
      ],
    );
  }

  Widget _buildSaveButton() {
    return WaterButton(
      onPressed: () {
        final language = 'en';
        final firstName = _firstNameController.text;
        final lastName = _lastNameController.text;
        final phoneNumber = _phoneNumberController.text;
        final birthday = _birthdayDatePickerKey.currentState!.value;
        final nationality = _nationalityController.text;
        final city = _cityController.text;
        final district = _districtController.text;
        final street = _streetController.text;
        final building = _buildingController.text;
        final floor = _floorController.text;
        final apartment = _apartmentController.text;
        final familyMembersAmount = _familyMembersPickerKey.currentState!.value;

        context.profile.add(
          SaveProfile(
            firstName: firstName.isNotEmpty ? firstName : null,
            lastName: lastName.isNotEmpty ? lastName : null,
            phoneNumber: phoneNumber.isNotEmpty ? phoneNumber : null,
            birthday: birthday,
            nationality: nationality.isNotEmpty ? nationality : null,
            city: city.isNotEmpty ? city : null,
            district: district.isNotEmpty ? district : null,
            street: street.isNotEmpty ? street : null,
            building: building.isNotEmpty ? building : null,
            floor: floor.isNotEmpty ? floor : null,
            apartment: apartment.isNotEmpty ? apartment : null,
            familyMembersAmount: familyMembersAmount,
            language: language,
          ),
        );
      },
      text: 'button.save'.tr(),
    );
  }

  Widget _buildChangePasswordButton() {
    return WaterButton(
      onPressed: () {},
      text: 'button.change_password'.tr(),
    );
  }

  Widget _buildLogOutButton() {
    return WaterButton(
      onPressed: () {
        context.auth.add(Logout());
      },
      text: 'button.logout'.tr(),
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
    );
  }
}
