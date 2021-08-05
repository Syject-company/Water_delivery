import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/domain/model/home/data/cities.dart';
import 'package:water/domain/model/home/profile/city.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/router.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_notification_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/input/form_fields.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

import 'delivery_navigator.dart';

class DeliveryScreen extends StatefulWidget {
  DeliveryScreen({Key? key}) : super(key: key);

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();

  City? _selectedCity;
  String? _selectedDistrict;

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
        onPressed: () => homeNavigator.currentState!.pop(),
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
      child: Column(
        children: <Widget>[
          WaterFormSelect<City>(
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
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'input.address'.tr(),
            hintText: 'input.address'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'input.building'.tr(),
            hintText: 'input.building'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'input.floor'.tr(),
            hintText: 'input.floor'.tr(),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            labelText: 'input.apartment'.tr(),
            hintText: 'input.apartment'.tr(),
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
        onPressed: () {
          deliveryNavigator.pushNamed(DeliveryRoutes.time);
        },
        text: 'button.next'.tr(),
      ),
    );
  }
}
