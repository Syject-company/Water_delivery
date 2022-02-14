import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

class SubscriptionDurationPicker extends StatefulWidget {
  const SubscriptionDurationPicker({
    Key? key,
    this.onSelected,
  }) : super(key: key);

  final void Function(int)? onSelected;

  @override
  _SubscriptionDurationPickerState createState() =>
      _SubscriptionDurationPickerState();
}

class _SubscriptionDurationPickerState
    extends State<SubscriptionDurationPicker> {
  int? _selectedDuration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.0),
        border: const Border.fromBorderSide(defaultBorder),
        color: AppColors.white,
      ),
      child: SeparatedRow(
        children: [
          _buildDurationButton(1),
          _buildDurationButton(2),
          _buildDurationButton(3),
        ],
        separator: const SizedBox(width: 12.0),
      ),
    );
  }

  Widget _buildDurationButton(int months) {
    return Expanded(
      child: _MonthButton(
        onPressed: () {
          setState(() {
            widget.onSelected?.call(_selectedDuration = months);
          });
        },
        selected: _selectedDuration?.toInt() == months,
        months: months,
      ),
    );
  }
}

class _MonthButton extends StatelessWidget {
  const _MonthButton({
    Key? key,
    required this.months,
    this.selected = false,
    this.onPressed,
  }) : super(key: key);

  final int months;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.primaryLight,
          ),
          color: selected ? AppColors.primary : AppColors.primaryLight,
        ),
        height: 48.0,
        child: Center(
          child: WaterText(
            'text.months'.plural(months),
            maxLines: 1,
            fontSize: 15.0,
            lineHeight: 1.25,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
