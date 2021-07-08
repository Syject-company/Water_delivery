import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/radio/radio_group.dart';

enum Language {
  English,
  Arabic,
}

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  static const String _logoIconPath = 'assets/svg/drop_icon.svg';
  static const String _logoTextPath = 'assets/svg/logo_text_red.svg';
  static const double _iconWidthFactor = 4.5;
  static const double _logoTextWidthFactor = 3.5;

  Language _language = Language.English;
  TextDirection _textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _textDirection,
      child: Scaffold(
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
      'Select Language',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLanguagePicker() {
    return RadioGroup<Language>(
      onChanged: (value) {
        setState(() {
          if (value == Language.English)
            _textDirection = TextDirection.ltr;
          else
            _textDirection = TextDirection.rtl;
        });
      },
      values: [
        Language.English,
        Language.Arabic,
      ],
      labels: [
        'English',
        'ةيبرعلا',
      ],
      groupValue: _language,
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        elevation: 0.0,
        padding: EdgeInsets.zero,
        fixedSize: Size(MediaQuery.of(context).size.width, 58),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      child: Text(
        'Save',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
