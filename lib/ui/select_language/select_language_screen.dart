import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water/ui/constants/colors.dart';

enum Language {
  English,
  Arabic,
}

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  static const String _logoIconPath = 'assets/svg/drop_icon.svg';
  static const String _logoTextPath = 'assets/svg/logo_text_red.svg';
  static const double _iconWidthFactor = 4.5;
  static const double _logoTextWidthFactor = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                _logoIconPath,
                color: AppColors.splashIconColor,
                width: MediaQuery.of(context).size.width / _iconWidthFactor,
              ),
              const SizedBox(height: 24.0),
              SvgPicture.asset(
                _logoTextPath,
                width: MediaQuery.of(context).size.width / _logoTextWidthFactor,
              ),
              const SizedBox(height: 32.0),
              Text(
                'Select Language',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 21.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: Language.English,
                        groupValue: Language.English,
                        onChanged: (value) {},
                      ),
                      Text(
                        'English',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 146, 171, 186),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: Language.Arabic,
                        groupValue: true,
                        onChanged: (value) {},
                      ),
                      Text(
                        'ةيبرعلا',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 146, 171, 186),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  fixedSize: Size(MediaQuery.of(context).size.width, 48),
                  backgroundColor: Color.fromARGB(255, 0, 92, 185),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: Text(
                  'Save',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
