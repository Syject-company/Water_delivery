import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/ui/constants/colors.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    this.showIcon = true,
    this.showLabel = true,
    this.iconWidthFactor = _iconWidthFactor,
    this.labelWidthFactor = _labelWidthFactor,
  }) : super(key: key);

  static const String _logoIconPath = 'assets/svg/logo_icon.svg';
  static const String _logoLabelPath = 'assets/svg/logo_label.svg';
  static const double _iconWidthFactor = 3.0;
  static const double _labelWidthFactor = 2.5;

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
        if (showLabel) const SizedBox(height: 24.0),
        if (showLabel) _buildLabel(context),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return SvgPicture.asset(
      _logoIconPath,
      color: AppColors.secondaryColor,
      width: MediaQuery.of(context).size.width / iconWidthFactor,
    );
  }

  Widget _buildLabel(BuildContext context) {
    return SvgPicture.asset(
      _logoLabelPath,
      width: MediaQuery.of(context).size.width / labelWidthFactor,
    );
  }
}
