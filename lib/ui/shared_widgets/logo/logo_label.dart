import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/ui/constants/paths.dart';

class WaterLogoLabel extends StatelessWidget {
  const WaterLogoLabel({
    Key? key,
    this.widthFactor = 2.75,
    this.color,
  }) : super(key: key);

  final double widthFactor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Paths.logo_label_white,
      width: MediaQuery.of(context).size.width / widthFactor,
      color: color,
    );
  }
}
