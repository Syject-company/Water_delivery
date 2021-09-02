import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/domain/model/delivery/date.dart';
import 'package:water/ui/extensions/date_time.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';
import 'package:water/util/separated_column.dart';
import 'package:water/util/separated_row.dart';

class DeliveryTimePicker extends StatefulWidget {
  const DeliveryTimePicker({
    Key? key,
    required this.dates,
    this.onSelected,
  }) : super(key: key);

  final List<DeliveryDate> dates;
  final void Function(DeliveryTime)? onSelected;

  @override
  _DeliveryTimePickerState createState() => _DeliveryTimePickerState();
}

class _DeliveryTimePickerState extends State<DeliveryTimePicker> {
  DeliveryTime? _selectedDate;

  List<DeliveryDate> get _dates => widget.dates;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: SeparatedRow(
        children: _dates.map((date) {
          return _buildDeliveryDate(date);
        }).toList(),
        separator: const SizedBox(width: 12.0),
      ),
    );
  }

  Widget _buildDeliveryDate(DeliveryDate date) {
    final locale = Localization.currentLocale(context).languageCode;
    final parsedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date.date);
    final formattedDayOfWeek;
    if (parsedDate.isToday) {
      formattedDayOfWeek = 'text.today'.tr();
    } else if (parsedDate.isTomorrow) {
      formattedDayOfWeek = 'text.tomorrow'.tr();
    } else {
      formattedDayOfWeek = DateFormat('EEEE', locale).format(parsedDate);
    }
    final formattedDayOfMonth = DateFormat('dd/MM', locale).format(parsedDate);

    return Container(
      width: 144.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.0),
        border: Border.all(color: AppColors.borderColor),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          if (date.periods.isNotEmpty) _buildPeriods(date),
        ],
      ),
    );
  }

  Widget _buildPeriods(DeliveryDate date) {
    return SeparatedColumn(
      children: date.periods.map((period) {
        return _PeriodButton(
          onPressed: () {
            setState(() {
              widget.onSelected?.call(
                _selectedDate = DeliveryTime(
                  date: date.date,
                  period: period,
                ),
              );
            });
          },
          selected: _selectedDate?.period == period,
          available: date.available,
          period: period,
        );
      }).toList(),
      separator: const SizedBox(height: 12.0),
    ).withPadding(0.0, 16.0, 0.0, 0.0);
  }
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({
    Key? key,
    required this.period,
    required this.available,
    this.selected = false,
    this.onPressed,
  }) : super(key: key);

  final Period period;
  final bool available;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final locale = Localization.currentLocale(context).languageCode;
    final startTime = DateFormat('h').parse('${period.startTime}');
    final endTime = DateFormat('h').parse('${period.endTime}');
    final formattedStartDate = DateFormat('h a', locale).format(startTime);
    final formattedEndTime = DateFormat('h a', locale).format(endTime);

    return (available)
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
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildAvailableButton(
    String formattedStartDate,
    String formattedEndTime,
  ) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
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
