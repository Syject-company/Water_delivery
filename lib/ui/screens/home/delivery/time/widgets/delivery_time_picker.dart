import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/domain/model/home/delivery/delivery_time.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/date_time.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/separated_column.dart';
import 'package:water/util/separated_row.dart';

class DeliveryTimePicker extends StatefulWidget {
  const DeliveryTimePicker({
    Key? key,
    required this.times,
    this.onSelected,
  }) : super(key: key);

  final List<DeliveryTime> times;
  final void Function(SelectedTime)? onSelected;

  @override
  _DeliveryTimePickerState createState() => _DeliveryTimePickerState();
}

class _DeliveryTimePickerState extends State<DeliveryTimePicker> {
  SelectedTime? _selectedTime;

  List<DeliveryTime> get _times => widget.times;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: SeparatedRow(
        children: _times.map((time) => _buildDeliveryTime(time)).toList(),
        separator: const SizedBox(width: 12.0),
      ),
    );
  }

  Widget _buildDeliveryTime(DeliveryTime time) {
    final date = DateFormat('yyyy-MM-dd').parse(time.date);
    final formattedDayOfWeek;
    if (date.isToday) {
      formattedDayOfWeek = 'Today';
    } else if (date.isTomorrow) {
      formattedDayOfWeek = 'Tomorrow';
    } else {
      formattedDayOfWeek = DateFormat('EEEE').format(date);
    }
    final formattedDayOfMonth = DateFormat('dd/MM').format(date);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.0),
        border: Border.all(color: AppColors.borderColor),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WaterText(
            formattedDayOfWeek,
            fontSize: 15.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: 8.0),
          WaterText(
            formattedDayOfMonth,
            fontSize: 20.0,
            lineHeight: 2.0,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          _buildPeriods(time),
        ],
      ),
    );
  }

  Widget _buildPeriods(DeliveryTime time) {
    return SeparatedColumn(
      children: time.periods
          .map(
            (period) => _PeriodButton(
              onPressed: () {
                setState(() {
                  widget.onSelected?.call(
                    _selectedTime = SelectedTime(
                      date: time.date,
                      period: period,
                    ),
                  );
                });
              },
              selected: _selectedTime?.period == period,
              period: period,
            ),
          )
          .toList(),
      separator: const SizedBox(height: 12.0),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({
    Key? key,
    required this.period,
    this.selected = false,
    this.onPressed,
  }) : super(key: key);

  final Period period;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final startTime = DateFormat('h').parse('${period.startTime}');
    final endTime = DateFormat('h').parse('${period.endTime}');
    final formattedStartDate = DateFormat('h a').format(startTime);
    final formattedEndTime = DateFormat('h a').format(endTime);

    return period.available
        ? _buildAvailableButton(formattedStartDate, formattedEndTime)
        : _buildUnavailableButton(formattedStartDate, formattedEndTime);
  }

  Widget _buildUnavailableButton(
    String formattedStartDate,
    String formattedEndTime,
  ) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColors.borderColor),
        color: AppColors.white,
      ),
      height: 48.0,
      child: Center(
        child: WaterText(
          '$formattedStartDate - $formattedEndTime',
          maxLines: 1,
          lineHeight: 1.25,
          textAlign: TextAlign.center,
          color: AppColors.disabled,
        ),
      ),
    );
  }

  Widget _buildAvailableButton(
    String formattedStartDate,
    String formattedEndTime,
  ) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.secondary,
          ),
          color: selected ? AppColors.primary : AppColors.secondary,
        ),
        height: 48.0,
        child: Center(
          child: WaterText(
            '$formattedStartDate - $formattedEndTime',
            maxLines: 1,
            lineHeight: 1.25,
            textAlign: TextAlign.center,
            color: selected ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
