import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';

class Label extends StatelessWidget {
  const Label(
    this.text, {
    Key? key,
    required this.fontSize,
    this.lineHeight,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w600,
    this.color = AppColors.primaryTextColor,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final double? lineHeight;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ).poppins,
      strutStyle: lineHeight != null
          ? StrutStyle(
              forceStrutHeight: true,
              height: lineHeight,
            )
          : null,
      textAlign: textAlign,
    );
  }
}
