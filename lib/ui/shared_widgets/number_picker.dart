import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/button/icon_button.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const double _smallFontSize = 18.0;
const double _smallIconSize = 21.0;
const double _smallBorderRadius = 10.0;
const double _smallButtonSize = 45.0;
const double _largeFontSize = 24.0;
const double _largeIconSize = 26.0;
const double _largeBorderRadius = 12.0;
const double _largeButtonSize = 56.0;

enum PickerSize { small, large }

class WaterNumberPicker extends StatefulWidget {
  const WaterNumberPicker({
    Key? key,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 999,
    this.step = 1,
    this.showBorder = true,
    this.initialValue,
    this.size = PickerSize.small,
  }) : super(key: key);

  final ValueChanged<int> onChanged;
  final int minValue;
  final int maxValue;
  final int step;
  final bool showBorder;
  final int? initialValue;
  final PickerSize size;

  @override
  _WaterNumberPickerState createState() => _WaterNumberPickerState();
}

class _WaterNumberPickerState extends State<WaterNumberPicker> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue ?? widget.minValue;
    widget.onChanged(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        if (widget.showBorder)
          Container(
            height: widget.size == PickerSize.small
                ? _smallButtonSize
                : _largeButtonSize,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(
                  widget.size == PickerSize.small
                      ? _smallBorderRadius
                      : _largeBorderRadius),
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
      fontSize:
          widget.size == PickerSize.small ? _smallFontSize : _largeFontSize,
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
      width:
          widget.size == PickerSize.small ? _smallButtonSize : _largeButtonSize,
      height:
          widget.size == PickerSize.small ? _smallButtonSize : _largeButtonSize,
      iconSize:
          widget.size == PickerSize.small ? _smallIconSize : _largeIconSize,
      borderRadius: widget.size == PickerSize.small
          ? _smallBorderRadius
          : _largeBorderRadius,
      backgroundColor:
          _counter > 0 ? AppColors.primary : AppColors.secondary,
      foregroundColor: _counter > 0 ? AppColors.white : AppColors.primaryText,
    );
  }
}
