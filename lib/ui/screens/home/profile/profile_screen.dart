import 'package:flutter/material.dart';
import 'package:water/domain/model/home/data/cities.dart';
import 'package:water/domain/model/home/data/nationalities.dart';
import 'package:water/domain/model/home/profile/city.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_fields.dart';
import 'package:water/ui/shared_widgets/number_picker.dart';
import 'package:water/ui/shared_widgets/radio/radio_group.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/util/localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();

  City? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLanguageText(),
          const SizedBox(height: 24.0),
          _buildLanguagePicker(context),
          const SizedBox(height: 24.0),
          _buildUserInputForm(context),
          const SizedBox(height: 24.0),
          _buildDeliveryText(),
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
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 24.0),
      child: WaterText(
        'Language',
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildLanguagePicker(BuildContext context) {
    return WaterRadioGroup<Locale>(
      onChanged: (locale) {
        Localization.changeLocale(context, locale);
      },
      values: {
        const Locale('en'): 'English',
        const Locale('ar'): 'العربية',
      },
      currentValue: Localization.currentLocale(context),
      axis: Axis.horizontal,
      spaceBetween: 24.0,
      labelFontSize: 15.0,
      labelLineHeight: 1.25,
    );
  }

  Widget _buildUserInputForm(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          WaterFormInput(
            hintText: 'First Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'Last Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'Email',
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
            hintText: 'Birthday',
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect(
            hintText: 'Nationality',
            items: {
              for (final nationality in nationalities) nationality: nationality,
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryText() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 24.0),
      child: WaterText(
        'Delivery address',
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildDeliveryInputForm() {
    return Form(
      child: Column(
        children: <Widget>[
          WaterFormSelect<City>(
            hintText: 'Select Emirate',
            items: {
              for (final city in cities) city: city.name,
            },
            onChanged: (city) {
              setState(() => _selectedCity = city);
              _districtSelectKey.currentState!.reset();
            },
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect<String>(
            key: _districtSelectKey,
            hintText: 'Select District',
            items: {
              for (final district in _selectedCity?.districts ?? [])
                district: district,
            },
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'Street Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'Building Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'Floor',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            hintText: 'Apartment',
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyMembersPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: WaterText(
            'Family Members',
            fontSize: 18.0,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 12.0),
          child: WaterNumberPicker(
            onChanged: (value) {},
            maxWidth: 144.0,
            minValue: 1,
          ),
        )
      ],
    );
  }

  Widget _buildSaveButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Save',
    );
  }

  Widget _buildChangePasswordButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Change Password',
    );
  }

  Widget _buildLogOutButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Log Out',
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
    );
  }
}
