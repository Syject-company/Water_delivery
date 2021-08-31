import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/subscription/subscription_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/domain/model/data/cities.dart';
import 'package:water/domain/model/delivery/address.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/screens/home/subscription/subscription_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/field.dart';

class DeliveryAddressScreen extends StatefulWidget {
  DeliveryAddressScreen({Key? key}) : super(key: key);

  @override
  _DeliveryAddressScreenState createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) async {
        if (state is SubscriptionDurationInput && state.push) {
          await subscriptionNavigator
              .pushNamed(SubscriptionRoutes.subscriptionDuration);
          context.subscription.add(BackPressed());
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: const BouncingScrollPhysics(),
          child: _buildDeliveryInputForm(),
        ),
        bottomNavigationBar: _buildNextButton(),
      ),
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
    _cityController.text = context.profile.state.city ?? '';
    _districtController.text = context.profile.state.district ?? '';
    _districtSelectKey.currentState?.setItems(
      cities.firstWhereOrNull((city) {
            return city.name == context.profile.state.city;
          })?.districts ??
          [],
      reset: false,
    );
    _streetController.text = context.profile.state.street ?? '';
    _buildingController.text = context.profile.state.building ?? '';
    _floorController.text = context.profile.state.floor ?? '';
    _apartmentController.text = context.profile.state.apartment ?? '';

    return Form(
      key: _formKey,
      child: Column(
        children: [
          WaterFormSelect(
            controller: _cityController,
            labelText: 'input.select_emirate'.tr(),
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
            validator: FieldValidator(fieldName: 'Emirate').validator,
            enableSearch: false,
          ),
          const SizedBox(height: 16.0),
          WaterFormSelect(
            key: _districtSelectKey,
            controller: _districtController,
            labelText: 'input.select_district'.tr(),
            hintText: 'input.select_district'.tr(),
            helpText: 'input.select_district'.tr(),
            items: cities.firstWhereOrNull((city) {
                  return city.name == _cityController.text;
                })?.districts ??
                [],
            validator: FieldValidator(fieldName: 'District').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _streetController,
            labelText: 'input.street'.tr(),
            hintText: 'input.street'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Street').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _buildingController,
            labelText: 'input.building'.tr(),
            hintText: 'input.building'.tr(),
            keyboardType: TextInputType.text,
            validator: FieldValidator(fieldName: 'Building').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _floorController,
            labelText: 'input.floor'.tr(),
            hintText: 'input.floor'.tr(),
            keyboardType: TextInputType.number,
            validator: FieldValidator(fieldName: 'Floor').validator,
          ),
          const SizedBox(height: 16.0),
          WaterFormInput(
            controller: _apartmentController,
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
        if (!_formKey.currentState!.validate()) {
          return;
        }

        final city = _cityController.text;
        final district = _districtController.text;
        final street = _streetController.text;
        final building = _buildingController.text;
        final floor = _floorController.text;
        final apartment = _apartmentController.text;

        context.subscription.add(
          SubmitDeliveryAddress(
            address: DeliveryAddress(
              city: city,
              district: district,
              street: street,
              building: building,
              floor: floor,
              apartment: apartment,
            ),
          ),
        );
      },
      text: 'button.next'.tr(),
    ).withPaddingAll(24.0);
  }
}
