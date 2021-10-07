import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:water/ui/shared_widgets/water.dart';

const double _iconSize = 32.0;
const String _whatsAppPhoneNumber = '+971559971101';

class AppBarWhatsappButton extends StatelessWidget {
  const AppBarWhatsappButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final urlAndroid =
            'whatsapp://send?phone=$_whatsAppPhoneNumber&text=hello';
        final urlIOS =
            'https://wa.me/$_whatsAppPhoneNumber?text=${Uri.parse("hello")}';

        if (Platform.isIOS) {
          if (await canLaunch(urlIOS)) {
            await launch(urlIOS, forceSafariVC: false);
          } else {
            _errorMessage(context);
          }
        } else {
          if (await canLaunch(urlAndroid)) {
            await launch(urlAndroid);
          } else {
            _errorMessage(context);
          }
        }
      },
      child: Center(
        child: Icon(
          AppIcons.whatsapp,
          color: AppColors.appBarIconColor,
          size: _iconSize,
        ),
      ),
    );
  }

  void _errorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: new WaterText(
          'WhatsApp not installed',
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
