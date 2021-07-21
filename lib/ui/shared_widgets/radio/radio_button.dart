import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const Duration _fadeDuration = const Duration(milliseconds: 125);
const double _circleWidth = 24.0;
const double _circleHeight = 24.0;
const double _circleBorderWidth = 1.0;
const double _labelFontSize = 18.0;
const double _labelLineHeight = 1.75;

class WaterRadioButton extends StatelessWidget {
  const WaterRadioButton({
    Key? key,
    required this.label,
    this.selected = false,
  }) : super(key: key);

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedContainer(
          duration: _fadeDuration,
          width: _circleWidth,
          height: _circleHeight,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? AppColors.primaryColor : Colors.transparent,
            border: Border.all(
              width: _circleBorderWidth,
              color: selected
                  ? AppColors.primaryColor
                  : AppColors.secondaryTextColor,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          child: WaterText(
            label,
            color: AppColors.secondaryTextColor,
            fontSize: _labelFontSize,
            lineHeight: _labelLineHeight,
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }
}
