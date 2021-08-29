import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/domain/model/data/cities.dart';
import 'package:water/domain/model/data/nationalities.dart';
import 'package:water/domain/model/profile/city.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();

  String? _selectedNationality;
  City? _selectedCity;
  String? _selectedDistrict;

  @override
  void didUpdateWidget(ProfileScreen oldWidget) {
    context.profile.add(LoadProfile());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (_, state) {
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
              _buildUserInputForm(state, context),
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
    ProfileState state,
    BuildContext context,
  ) {
    final firstName = state.firstName;
    final lastName = state.lastName;
    final email = state.email;
    final phoneNumber = state.phoneNumber;
    final birthday = state.birthday;
    _selectedNationality = state.nationality;

    return Form(
      child: Column(
        children: [
          WaterFormInput(
            initialValue: firstName,
            hintText: 'input.first_name'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            initialValue: lastName,
            hintText: 'input.last_name'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            initialValue: email,
            hintText: 'input.email'.tr(),
            readOnly: true,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            initialValue: phoneNumber,
            hintText: '00971544400611',
            prefixIcon: Icon(
              AppIcons.phone,
              size: 32.0,
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16.0),
          WaterFormDatePicker(
            hintText: 'input.birthday'.tr(),
            helpText: 'input.select_birthday_date'.tr(),
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect<String>(
            initialValue: _selectedNationality,
            hintText: 'input.nationality'.tr(),
            helpText: 'input.select_nationality'.tr(),
            onChanged: (nationality) {
              setState(() => _selectedNationality = nationality);
            },
            items: {
              for (final nationality in nationalities) nationality: nationality,
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInputForm(ProfileState state) {
    _selectedCity = cities.firstWhereOrNull((city) {
      return city.name == state.city;
    });
    _selectedDistrict = state.district;
    final street = state.street;
    final building = state.building;
    final floor = state.floor;
    final apartment = state.apartment;

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
          WaterFormSelect<City>(
            initialValue: _selectedCity,
            hintText: 'input.select_emirate'.tr(),
            helpText: 'input.select_emirate'.tr(),
            onChanged: (city) {
              setState(() => _selectedCity = city);
              _districtSelectKey.currentState!.reset();
            },
            items: {
              for (final city in cities) city: city.name,
            },
            enableSearch: false,
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect<String>(
            key: _districtSelectKey,
            initialValue: _selectedDistrict,
            hintText: 'input.select_district'.tr(),
            helpText: 'input.select_district'.tr(),
            onChanged: (district) {
              setState(() => _selectedDistrict = district);
            },
            items: {
              for (final district in _selectedCity?.districts ?? [])
                district: district,
            },
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            initialValue: street,
            hintText: 'input.street'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            initialValue: building,
            hintText: 'input.building'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            initialValue: floor,
            hintText: 'input.floor'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            initialValue: apartment,
            hintText: 'input.apartment'.tr(),
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyMembersPicker(ProfileState state) {
    final familyMembersAmount = state.familyMembersCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.family_members'.tr(),
          fontSize: 18.0,
          lineHeight: 1.75,
        ).withPadding(24.0, 0.0, 24.0, 0.0),
        WaterNumberPicker(
          value: familyMembersAmount,
          onChanged: (value) {},
          maxWidth: 144.0,
          minValue: 0,
        ).withPadding(0.0, 0.0, 12.0, 0.0),
      ],
    );
  }

  Widget _buildSaveButton() {
    return WaterButton(
      onPressed: () {},
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
