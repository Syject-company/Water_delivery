import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';

class WaterText extends StatelessWidget {
  const WaterText(
    this.text, {
    Key? key,
    this.fontSize = 15.0,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.w600,
    this.color = AppColors.primaryText,
    this.softWrap,
    this.lineHeight,
    this.maxLines,
    this.overflow,
    this.decoration,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Color color;
  final bool? softWrap;
  final double? lineHeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: softWrap,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      textDirection: Directionality.of(context),
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
      ).poppins,
      strutStyle: lineHeight != null
          ? StrutStyle(
              forceStrutHeight: true,
              height: lineHeight,
            )
          : null,
    );
  }
}
