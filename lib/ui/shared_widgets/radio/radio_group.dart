import 'package:flutter/material.dart';

import 'radio_button.dart';

class WaterRadioGroup<T> extends StatefulWidget {
  WaterRadioGroup({
    Key? key,
    required this.values,
    required this.onChanged,
    this.currentValue,
    this.axis = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBetween = 16.0,
    this.labelFontSize,
    this.labelLineHeight,
  })  : assert(spaceBetween >= 0.0),
        super(key: key);

  final Map<T, String> values;
  final ValueChanged<T> onChanged;
  final T? currentValue;
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBetween;
  final double? labelFontSize;
  final double? labelLineHeight;

  @override
  _WaterRadioGroupState<T> createState() => _WaterRadioGroupState();
}

class _WaterRadioGroupState<E> extends State<WaterRadioGroup<E>> {
  late E? _selectedValue = widget.currentValue;

  @override
  Widget build(BuildContext context) {
    return widget.axis == Axis.vertical
        ? Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRadioButtons(),
          )
        : Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildRadioButtons(),
          );
  }

  List<Widget> _buildRadioButtons() {
    final buttons = <Widget>[];

    widget.values.forEach((value, label) {
      buttons.add(
        GestureDetector(
          onTap: () {
            if (_selectedValue != value) {
              setState(() => _selectedValue = value);
              widget.onChanged(_selectedValue!);
            }
          },
          child: WaterRadioButton(
            label: label,
            selected: _selectedValue != null && _selectedValue == value,
            labelFontSize: widget.labelFontSize,
            labelLineHeight: widget.labelLineHeight,
          ),
          behavior: HitTestBehavior.opaque,
        ),
      );

      if (value != widget.values.keys.last) {
        buttons.add(widget.axis == Axis.vertical
            ? SizedBox(height: widget.spaceBetween)
            : SizedBox(width: widget.spaceBetween));
      }
    });

    return buttons;
  }
}
