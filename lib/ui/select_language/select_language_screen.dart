import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/radio/radio_group.dart';
import 'package:water/util/localization.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  static const String _logoIconPath = 'assets/svg/logo_icon.svg';
  static const String _logoTextPath = 'assets/svg/logo_text_red.svg';
  static const double _iconWidthFactor = 4.5;
  static const double _logoTextWidthFactor = 3.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogoIcon(),
              const SizedBox(height: 24.0),
              _buildLogoText(),
              const SizedBox(height: 32.0),
              _buildSelectLanguageLabel(),
              const SizedBox(height: 32.0),
              _buildLanguagePicker(),
              const SizedBox(height: 40.0),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoIcon() {
    return SvgPicture.asset(
      _logoIconPath,
      color: AppColors.splashIconColor,
      width: MediaQuery.of(context).size.width / _iconWidthFactor,
    );
  }

  Widget _buildLogoText() {
    return SvgPicture.asset(
      _logoTextPath,
      width: MediaQuery.of(context).size.width / _logoTextWidthFactor,
    );
  }

  Widget _buildSelectLanguageLabel() {
    return Text(
      'text.select_language'.tr(),
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      strutStyle: const StrutStyle(
        forceStrutHeight: true,
        height: 2.0,
      ),
    );
  }

  Widget _buildLanguagePicker() {
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

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        final currentLocale = Localization.currentLocale(context);
        Localization.saveLocale(currentLocale);
        // TODO: navigate to home
      },
      style: TextButton.styleFrom(
        elevation: 0.0,
        padding: EdgeInsets.zero,
        fixedSize: Size(MediaQuery.of(context).size.width, 58.0),
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      child: Text(
        'button.save'.tr(),
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
          height: 1.25,
        ),
      ),
    );
  }
}
