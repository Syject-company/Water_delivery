import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/checkout/dates/dates_bloc.dart';
import 'package:water/bloc/home/checkout/order/order_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/domain/model/data/cities.dart';
import 'package:water/domain/model/delivery/address.dart';
import 'package:water/ui/screens/home/checkout/order/order_navigator.dart';
import 'package:water/ui/screens/home/home_navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/ui/validators/field.dart';

class DeliveryAddressScreen extends StatelessWidget {
  DeliveryAddressScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _deliveryAddressFormKey = GlobalKey();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final GlobalKey<WaterFormSelectState> _districtSelectKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) async {
        if (state is DeliveryTimeInput && state.push) {
          context.deliveryDates.add(
            LoadDeliveryDates(city: state.address.city),
          );
          await orderNavigator.pushNamed(OrderRoutes.deliveryTime);
          context.order.add(BackPressed());
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
        bottomNavigationBar: _buildNextButton(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar(
      title: WaterText(
        'screen.delivery'.tr(),
        fontSize: 24.0,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
      ),
      leading: AppBarBackButton(
        onPressed: () {
          homeNavigator.pop();
        },
      ),
      actions: [
        AppBarWhatsappButton(),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      physics: const BouncingScrollPhysics(),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isMobile ? 100.w : 50.w,
          child: _buildDeliveryInputForm(context),
        ),
      ),
    );
  }

  Widget _buildDeliveryInputForm(BuildContext context) {
    final profile = context.profile.state;
    _cityController.text = profile.city ?? '';
    _districtController.text = profile.district ?? '';
    _districtSelectKey.currentState?.setItems(
      cities.firstWhereOrNull((city) {
            return city.name == profile.city;
          })?.districts ??
          [],
      reset: false,
    );
    _streetController.text = profile.street ?? '';
    _buildingController.text = profile.building ?? '';
    _floorController.text = profile.floor ?? '';
    _apartmentController.text = profile.apartment ?? '';

    return Form(
      key: _deliveryAddressFormKey,
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
            items: cities.map((city) => city.name).toList(growable: false),
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

  Widget _buildNextButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        border: Border(top: defaultBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WaterButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();

              if (!_deliveryAddressFormKey.currentState!.validate()) {
                return;
              }

              final city = _cityController.text;
              final district = _districtController.text;
              final street = _streetController.text;
              final building = _buildingController.text;
              final floor = _floorController.text;
              final apartment = _apartmentController.text;

              context.order.add(
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
          ),
        ],
      ),
    );
  }
}
