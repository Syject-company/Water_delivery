import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';
import 'package:water/util/separated_row.dart';

const double _circleWidth = 24.0;
const double _circleHeight = 24.0;
const double _circleBorderWidth = 1.0;
const double _labelFontSize = 18.0;
const double _labelLineHeight = 1.75;

class WaterRadioGroup<T> extends StatefulWidget {
  WaterRadioGroup({
    Key? key,
    required this.values,
    required this.onChanged,
    this.initialValue,
    this.axis = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBetween = 16.0,
    this.labelFontSize,
    this.labelLineHeight,
  })  : assert(spaceBetween >= 0.0),
        super(key: key);

  final Map<T, String> values;
  final ValueChanged<T> onChanged;
  final T? initialValue;
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBetween;
  final double? labelFontSize;
  final double? labelLineHeight;

  @override
  _WaterRadioGroupState<T> createState() => _WaterRadioGroupState();
}

class _WaterRadioGroupState<E> extends State<WaterRadioGroup<E>> {
  late E? _selectedValue = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return widget.axis == Axis.vertical
        ? SeparatedColumn(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start,
            separator: SizedBox(height: widget.spaceBetween),
            children: _buildRadioButtons(),
          )
        : SeparatedRow(
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            separator: SizedBox(width: widget.spaceBetween),
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
          child: _RadioButton(
            label: label,
            selected: _selectedValue != null && _selectedValue == value,
            labelFontSize: widget.labelFontSize,
            labelLineHeight: widget.labelLineHeight,
          ),
          behavior: HitTestBehavior.opaque,
        ),
      );
    });

    return buttons;
  }
}

class _RadioButton extends StatelessWidget {
  const _RadioButton({
    Key? key,
    required this.label,
    this.selected = false,
    this.labelFontSize,
    this.labelLineHeight,
  }) : super(key: key);

  final String label;
  final bool selected;
  final double? labelFontSize;
  final double? labelLineHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _circleWidth,
          height: _circleHeight,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? AppColors.primary : Colors.transparent,
            border: Border.all(
              width: _circleBorderWidth,
              color: selected ? AppColors.primary : AppColors.secondaryText,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          child: WaterText(
            label,
            color: AppColors.secondaryText,
            fontSize: labelFontSize ?? _labelFontSize,
            lineHeight: labelLineHeight ?? _labelLineHeight,
          ),
        )
      ],
    );
  }
}
