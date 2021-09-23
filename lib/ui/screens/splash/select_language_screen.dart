import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/main.dart';
import 'package:water/ui/extensions/navigator.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/local_storage.dart';
import 'package:water/util/localization.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WaterAppBar();
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
      physics: const BouncingScrollPhysics(),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isMobile ? 100.w : 50.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WaterLogo(),
              const SizedBox(height: 64.0),
              _buildSelectLanguageLabel(),
              const SizedBox(height: 32.0),
              _buildLanguagePicker(context),
              const SizedBox(height: 40.0),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectLanguageLabel() {
    return WaterText(
      'text.select_language'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText,
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
      initialValue: Localization.currentLocale(context),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return WaterButton(
      onPressed: () async {
        final currentLocale = Localization.currentLocale(context);
        await Localization.saveLocale(currentLocale);
        await LocalStorage.setFirstLaunch(false);

        appNavigator.pushReplacementNamed(AppRoutes.home);
      },
      text: 'button.save'.tr(),
    );
  }
}
