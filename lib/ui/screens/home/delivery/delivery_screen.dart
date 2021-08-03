import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:water/domain/model/home/data/cities.dart';
import 'package:water/domain/model/home/profile/city.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_notification_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_fields.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class DeliveryScreen extends StatefulWidget {
  DeliveryScreen({Key? key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();

  City? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 24.0),
            _buildSelectAddressButton(),
            const SizedBox(height: 24.0),
            _buildDeliveryInputForm(),
          ],
        ),
      ),
      bottomNavigationBar: _buildNextButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'Delivery',
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildSelectAddressButton() {
    return WaterButton(
      onPressed: () {},
      text: 'Use your current location',
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
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
            labelText: 'Address',
            hintText: 'Address',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'Building Name',
            hintText: 'Building Name',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'Floor',
            hintText: 'Floor',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'Apartment',
            hintText: 'Apartment',
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: WaterButton(
        onPressed: () {},
        text: 'Next',
      ),
    );
  }
}
