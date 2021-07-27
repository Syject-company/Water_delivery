import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/screens/router.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/logo/logo.dart';
import 'package:water/ui/shared_widgets/radio/radio_group.dart';
import 'package:water/ui/shared_widgets/text/text.dart';
import 'package:water/util/local_storage.dart';
import 'package:water/util/localization.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget _buildSelectLanguageLabel() {
    return WaterText(
      'select_language.title'.tr(),
      fontSize: 24.0,
      lineHeight: 2.0,
      textAlign: TextAlign.center,
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
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return WaterButton(
      onPressed: () async {
        final currentLocale = Localization.currentLocale(context);
        await Localization.saveLocale(currentLocale);
        await LocalStorage.setFirstLaunch(false);

        Navigator.of(context).pushReplacementNamed(AppRoutes.auth);
      },
      text: 'global.save'.tr(),
    );
  }
}
