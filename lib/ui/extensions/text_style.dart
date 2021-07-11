import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension PoppinsFontFamily on TextStyle {
  TextStyle get poppins {
    return GoogleFonts.poppins(
      textStyle: this,
    );
  }
}