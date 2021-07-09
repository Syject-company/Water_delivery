import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
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
          duration: Duration(milliseconds: 125),
          height: 24.0,
          width: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? AppColors.primaryColor : Colors.transparent,
            border: Border.all(
              width: 1.0,
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
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
