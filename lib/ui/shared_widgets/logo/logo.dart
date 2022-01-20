import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water/app_resources.dart';
import 'package:water/ui/shared_widgets/water.dart';

class WaterLogo extends StatelessWidget {
  const WaterLogo({
    Key? key,
    this.showIcon = true,
    this.showLabel = true,
    this.iconWidthFactor = 3.75,
    this.labelWidthFactor = 2.75,
    this.labelColor,
  }) : super(key: key);

  final bool showIcon;
  final bool showLabel;
  final double iconWidthFactor;
  final double labelWidthFactor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showIcon) _buildIcon(context),
        if (showIcon && showLabel) const SizedBox(height: 24.0),
        if (showLabel) _buildLabel(context),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return SvgPicture.asset(
      AppResources.logoIcon,
      color: AppColors.primaryLight,
      width: 100.w / (isMobile ? iconWidthFactor : iconWidthFactor * 1.5),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return SvgPicture.asset(
      AppResources.logoLabelColored,
      color: labelColor,
      width: 100.w / (isMobile ? labelWidthFactor : labelWidthFactor * 1.5),
    );
  }
}
