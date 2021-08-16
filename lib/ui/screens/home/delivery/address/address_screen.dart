import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/delivery/delivery_bloc.dart';
import 'package:water/domain/model/home/data/cities.dart';
import 'package:water/domain/model/home/delivery/address.dart';
import 'package:water/domain/model/home/profile/city.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/field.dart';

class DeliveryAddressScreen extends StatefulWidget {
  DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  _DeliveryAddressScreenState createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _citySelectKey = GlobalKey();
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _streetInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _buildingInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _floorInputKey = GlobalKey();
  final GlobalKey<WaterFormInputState> _apartmentInputKey = GlobalKey();

  City? _selectedCity;
  String? _selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        child: _buildDeliveryInputForm(),
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
        onPressed: () {
          homeNavigator.pop();
        },
      ),
      actions: [
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
        children: [
          WaterFormSelect<City>(
            key: _citySelectKey,
            initialValue: _selectedCity,
            labelText: 'input.select_emirate'.tr(),
            hintText: 'input.select_emirate'.tr(),
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
            labelText: 'input.select_district'.tr(),
            hintText: 'input.select_district'.tr(),
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
            key: _streetInputKey,
            labelText: 'input.street'.tr(),
            hintText: 'input.street'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Street').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            key: _buildingInputKey,
            labelText: 'input.building'.tr(),
            hintText: 'input.building'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Building').validator,
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
    return WaterButton(
      onPressed: () {
        // if (!_formKey.currentState!.validate()) {
        //   return;
        // }

        context.delivery.add(
          SubmitDeliveryAddress(
            address: DeliveryAddress(
              city: _citySelectKey.currentState!.value,
              district: _districtSelectKey.currentState!.value,
              street: _streetInputKey.currentState!.value,
              building: _buildingInputKey.currentState!.value,
              floor: _floorInputKey.currentState!.value,
              apartment: _apartmentInputKey.currentState!.value,
            ),
          ),
        );
      },
      text: 'button.next'.tr(),
    ).withPaddingAll(24.0);
  }
}
