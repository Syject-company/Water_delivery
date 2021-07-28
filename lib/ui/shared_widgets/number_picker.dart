import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/button/icon_button.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _smallFontSize = 15.0;
const double _smallIconSize = 16.0;
const double _smallBorderRadius = 8.0;
const double _smallButtonSize = 34.0;

const double _mediumFontSize = 18.0;
const double _mediumIconSize = 21.0;
const double _mediumBorderRadius = 10.0;
const double _mediumButtonSize = 45.0;

const double _largeFontSize = 24.0;
const double _largeIconSize = 26.0;
const double _largeBorderRadius = 12.0;
const double _largeButtonSize = 56.0;

enum PickerSize { small, medium, large }

class WaterNumberPicker extends StatefulWidget {
  const WaterNumberPicker({
    Key? key,
    required this.onChanged,
    this.alignment = Alignment.center,
    this.size = PickerSize.medium,
    this.minValue = 0,
    this.maxValue = 999,
    this.step = 1,
    this.showBorder = true,
    this.dynamicColor = true,
    this.value,
    this.maxWidth,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  final AlignmentGeometry alignment;
  final PickerSize size;
  final int minValue;
  final int maxValue;
  final int step;
  final bool showBorder;
  final bool dynamicColor;
  final int? value;
  final double? maxWidth;

  @override
  _WaterNumberPickerState createState() => _WaterNumberPickerState();
}

class _WaterNumberPickerState extends State<WaterNumberPicker> {
  late int _counter = widget.value ?? widget.minValue;

  @override
  void didUpdateWidget(WaterNumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _counter = widget.value ?? _counter;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth ?? double.infinity,
        ),
        child: Stack(
          children: <Widget>[
            if (widget.showBorder)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(_sizes.borderRadius),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDecrementButton(),
                Flexible(child: _buildCounter()),
                _buildIncrementButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecrementButton() {
    return _buildButton(
      onPressed: () {
        if (_counter - widget.step < widget.minValue) {
          setState(() => _counter = widget.minValue);
        } else {
          setState(() => _counter -= widget.step);
        }
        widget.onChanged(_counter);
      },
      icon: AppIcons.minus,
    );
  }

  Widget _buildCounter() {
    return WaterText(
      '$_counter',
      maxLines: 1,
      fontSize: _sizes.fontSize,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildIncrementButton() {
    return _buildButton(
      onPressed: () {
        if (_counter + widget.step > widget.maxValue) {
          setState(() => _counter = widget.maxValue);
        } else {
          setState(() => _counter += widget.step);
        }
        widget.onChanged(_counter);
      },
      icon: AppIcons.plus,
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return WaterIconButton(
      onPressed: onPressed,
      icon: icon,
      width: _sizes.buttonSize,
      height: _sizes.buttonSize,
      iconSize: _sizes.iconSize,
      borderRadius: _sizes.borderRadius,
      backgroundColor: _counter > 0 && widget.dynamicColor
          ? AppColors.primary
          : AppColors.secondary,
      foregroundColor: _counter > 0 && widget.dynamicColor
          ? AppColors.white
          : AppColors.primaryText,
    );
  }

  _Sizes get _sizes {
    switch (widget.size) {
      case PickerSize.small:
        return const _Sizes(
          fontSize: _smallFontSize,
          iconSize: _smallIconSize,
          borderRadius: _smallBorderRadius,
          buttonSize: _smallButtonSize,
        );
      case PickerSize.medium:
        return const _Sizes(
          fontSize: _mediumFontSize,
          iconSize: _mediumIconSize,
          borderRadius: _mediumBorderRadius,
          buttonSize: _mediumButtonSize,
        );
      case PickerSize.large:
        return const _Sizes(
          fontSize: _largeFontSize,
          iconSize: _largeIconSize,
          borderRadius: _largeBorderRadius,
          buttonSize: _largeButtonSize,
        );
    }
  }
}

class _Sizes {
  const _Sizes({
    required this.fontSize,
    required this.iconSize,
    required this.borderRadius,
    required this.buttonSize,
  });

  final double fontSize;
  final double iconSize;
  final double borderRadius;
  final double buttonSize;
}
