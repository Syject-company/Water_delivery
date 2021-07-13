import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    required this.label,
    this.selected = false,
  }) : super(key: key);

  static const Duration _fadeDuration = const Duration(milliseconds: 125);
  static const double _circleWidth = 24.0;
  static const double _circleHeight = 24.0;
  static const double _circleBorderWidth = 1.0;
  static const double _labelFontSize = 18.0;
  static const double _labelLineHeight = 1.75;

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
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: _labelFontSize,
              fontWeight: FontWeight.w600,
            ).poppins,
            strutStyle: const StrutStyle(
              forceStrutHeight: true,
              height: _labelLineHeight,
            ),
          ),
        )
      ],
    );
  }
}
