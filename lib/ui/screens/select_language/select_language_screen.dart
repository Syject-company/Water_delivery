import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/screens/auth/auth_screen.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/logo.dart';
import 'package:water/ui/shared_widgets/radio/radio_group.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/slide_with_fade_route.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Logo(),
              const SizedBox(height: 32.0),
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
    return Text(
      'text.select_language'.tr(),
      style: const TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ),
      strutStyle: const StrutStyle(
        forceStrutHeight: true,
        height: 2.0,
      ),
    );
  }

  Widget _buildLanguagePicker(BuildContext context) {
    return RadioGroup<Locale>(
      onChanged: (locale) {
        Localization.changeLocale(context, locale);
      },
      values: {
        const Locale('en'): 'English',
        const Locale('ar'): 'ةيبرعلا',
      },
      currentValue: Localization.currentLocale(context),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Button(
      onPressed: () async {
        // Save selected locale
        final currentLocale = Localization.currentLocale(context);
        await Localization.saveLocale(currentLocale);

        // TODO: extract
        // Disable first launch
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('first_launch', false);

        // Load Auth Screen
        Navigator.of(context).pushReplacement(
          SlideWithFadeRoute(
            builder: (_) => AuthScreen(),
          ),
        );
      },
      text: 'button.save'.tr(),
    );
  }
}
