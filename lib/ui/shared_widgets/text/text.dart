import 'package:flutter/material.dart';
import 'package:water/ui/extensions/text_style.dart';

class WaterText extends StatelessWidget {
  const WaterText(
    this.text, {
    Key? key,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.textAlign = TextAlign.start,
    this.lineHeight,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.softWrap,
  }) : super(key: key);

  final String text;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final Color color;
  final double? fontSize;
  final double? lineHeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: softWrap,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
      ).nunitoSans,
      strutStyle: lineHeight != null
          ? StrutStyle(
              forceStrutHeight: true,
              height: lineHeight,
            )
          : null,
    );
  }
}
