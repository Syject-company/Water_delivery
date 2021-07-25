import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_input.dart';
import 'package:water/ui/shared_widgets/input/select_form_input.dart';
import 'package:water/ui/shared_widgets/radio/radio_group.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/util/localization.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

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
          _buildUserInputForm(),
          const SizedBox(height: 24.0),
          _buildDeliveryText(),
          const SizedBox(height: 24.0),
          _buildDeliveryInputForm(),
          const SizedBox(height: 16.0),
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
        const Locale('ar'): 'ةيبرعلا',
      },
      currentValue: Localization.currentLocale(context),
      axis: Axis.horizontal,
      spaceBetween: 24.0,
      labelFontSize: 15.0,
      labelLineHeight: 1.25,
    );
  }

  Widget _buildUserInputForm() {
    return Form(
      child: Column(
        children: <Widget>[
          FormInput(
            labelText: 'First Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            labelText: 'Last Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            labelText: 'Email',
            readOnly: true,
            initialValue: 'example@example.com',
          ),
          const SizedBox(height: 16.0),
          FormInput(
            labelText: '+1234567890',
            prefixIcon: Icon(
              AppIcons.phone,
              size: 32.0,
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            labelText: 'Birthday',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          SelectFormInput(
            labelText: 'Nationality',
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
          SelectFormInput(
            labelText: 'Select City',
          ),
          const SizedBox(height: 16.0),
          SelectFormInput(
            labelText: 'Select District',
          ),
          const SizedBox(height: 16.0),
          FormInput(
            labelText: 'Select Street',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          FormInput(
            labelText: 'Select Building',
            keyboardType: TextInputType.text,
          ),
        ],
      ),
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
