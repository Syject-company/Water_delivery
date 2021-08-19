import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/domain/model/home/data/cities.dart';
import 'package:water/domain/model/home/data/nationalities.dart';
import 'package:water/domain/model/home/profile/city.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/session.dart';

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
  Widget build(BuildContext context) {
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
          _buildUserInputForm(context),
          const SizedBox(height: 24.0),
          _buildDeliveryInputForm(),
          const SizedBox(height: 24.0),
          _buildFamilyMembersPicker(),
          const SizedBox(height: 24.0),
          _buildSaveButton(),
          const SizedBox(height: 16.0),
          _buildChangePasswordButton(),
          const SizedBox(height: 16.0),
          _buildLogOutButton(),
        ],
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

  Widget _buildUserInputForm(BuildContext context) {
    return Form(
      child: Column(
        children: [
          WaterFormInput(
            hintText: 'input.first_name'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'input.last_name'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'input.email'.tr(),
            readOnly: true,
            initialValue: 'example@example.com',
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
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

  Widget _buildDeliveryInputForm() {
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
            hintText: 'input.street'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'input.building'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'input.floor'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'input.apartment'.tr(),
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyMembersPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WaterText(
          'text.family_members'.tr(),
          fontSize: 18.0,
          lineHeight: 1.75,
        ).withPadding(24.0, 0.0, 24.0, 0.0),
        WaterNumberPicker(
          onChanged: (value) {},
          maxWidth: 144.0,
          minValue: 1,
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
      onPressed: () => Session.invalidate(context),
      text: 'button.logout'.tr(),
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
    );
  }
}
