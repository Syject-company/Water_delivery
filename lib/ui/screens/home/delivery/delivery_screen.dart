import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/domain/model/home/data/cities.dart';
import 'package:water/domain/model/home/profile/city.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/router.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/field.dart';

import 'delivery_navigator.dart';

class DeliveryScreen extends StatefulWidget {
  DeliveryScreen({Key? key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _emirateSelectKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _addressInputKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _buildingInputKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _floorInputKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _apartmentInputKey = GlobalKey();

  City? _selectedCity;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
        'screen.delivery'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () => homeNavigator.pop(),
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

  Widget _buildDeliveryInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          WaterFormSelect<City>(
            key: _emirateSelectKey,
            initialValue: _selectedCity,
            labelText: 'input.emirate'.tr(),
            hintText: 'input.emirate'.tr(),
            helpText: 'input.select_emirate'.tr(),
            onChanged: (city) {
              setState(() => _selectedCity = city);
              _districtSelectKey.currentState!.reset();
            },
            items: {
              for (final city in cities) city: city.name,
            },
            validator: FieldValidator(fieldName: 'Emirate').validator,
            enableSearch: false,
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect<String>(
            key: _districtSelectKey,
            initialValue: _selectedDistrict,
            labelText: 'input.district'.tr(),
            hintText: 'input.district'.tr(),
            helpText: 'input.select_district'.tr(),
            onChanged: (district) {
              setState(() => _selectedDistrict = district);
            },
            items: {
              for (final district in _selectedCity?.districts ?? [])
                district: district,
            },
            validator: FieldValidator(fieldName: 'District').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _addressInputKey,
            labelText: 'input.address'.tr(),
            hintText: 'input.address'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Address').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _buildingInputKey,
            labelText: 'input.building'.tr(),
            hintText: 'input.building'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Building Name').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _floorInputKey,
            labelText: 'input.floor'.tr(),
            hintText: 'input.floor'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Floor').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _apartmentInputKey,
            labelText: 'input.apartment'.tr(),
            hintText: 'input.apartment'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Apartment').validator,
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: WaterButton(
        onPressed: () {
          // if (!_formKey.currentState!.validate()) {
          //   return;
          // }

          deliveryNavigator.pushNamed(DeliveryRoutes.time);
        },
        text: 'button.next'.tr(),
      ),
    );
  }
}
