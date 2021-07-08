import 'package:flutter/material.dart';

import 'radio_button.dart';

class RadioGroup<T> extends StatefulWidget {
  const RadioGroup({
    Key? key,
    required this.values,
    required this.labels,
    required this.groupValue,
    required this.onChanged,
    this.axis = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceBetween = 16.0,
  })  : assert(values.length == labels.length),
        assert(spaceBetween >= 0.0),
        super(key: key);

  final List<T> values;
  final List<String> labels;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;
  final double spaceBetween;

  @override
  _RadioGroupState<T> createState() => _RadioGroupState();
}

class _RadioGroupState<E> extends State<RadioGroup<E>> {
  late E selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.groupValue;
  }

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

    for (int i = 0; i < widget.values.length; i++) {
      buttons.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedValue = widget.values[i];
            });
            widget.onChanged(selectedValue);
          },
          child: RadioButton(
            label: widget.labels[i],
            selected: selectedValue == widget.values[i],
          ),
        ),
      );

      if (i != widget.values.length - 1) {
        buttons.add(widget.axis == Axis.vertical
            ? SizedBox(height: widget.spaceBetween)
            : SizedBox(width: widget.spaceBetween));
      }
    }

    return buttons;
  }
}
