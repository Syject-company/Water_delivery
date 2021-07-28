import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/constants/paths.dart';

class WaterLogo extends StatelessWidget {
  const WaterLogo({
    Key? key,
    this.showIcon = true,
    this.showLabel = true,
    this.iconWidthFactor = 3.25,
    this.labelWidthFactor = 2.75,
  }) : super(key: key);

  final bool showIcon;
  final bool showLabel;
  final double iconWidthFactor;
  final double labelWidthFactor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (showIcon) _buildIcon(context),
        if (showIcon && showLabel) const SizedBox(height: 24.0),
        if (showLabel) _buildLabel(context),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return SvgPicture.asset(
      Paths.logo_icon,
      color: AppColors.secondary,
      width: MediaQuery.of(context).size.width / iconWidthFactor,
    );
  }

  Widget _buildLabel(BuildContext context) {
    return SvgPicture.asset(
      Paths.logo_label,
      width: MediaQuery.of(context).size.width / labelWidthFactor,
    );
  }
}
