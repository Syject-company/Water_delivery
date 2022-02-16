import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/domain/model/delivery/date.dart';
import 'package:water/ui/extensions/date_time.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/utils/localization.dart';

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
        }).toList(growable: false),
        separator: const SizedBox(width: 12.0),
      ),
    );
  }

  Widget _buildDeliveryDate(DeliveryDate deliveryDate) {
    final locale = Localization.currentLocale(context).languageCode;
    final String formattedDayOfWeek;
    if (deliveryDate.date.isToday) {
      formattedDayOfWeek = 'text.today'.tr();
    } else if (deliveryDate.date.isTomorrow) {
      formattedDayOfWeek = 'text.tomorrow'.tr();
    } else {
      formattedDayOfWeek = DateFormat('EEEE', locale).format(deliveryDate.date);
    }
    final formattedDayOfMonth =
        DateFormat('dd/MM', locale).format(deliveryDate.date);

    return Container(
      width: 144.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.0),
        border: const Border.fromBorderSide(defaultBorder),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WaterText(
            formattedDayOfWeek,
            fontSize: 16.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: 8.0),
          WaterText(
            formattedDayOfMonth,
            fontSize: 20.0,
            lineHeight: 2.0,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
          if (deliveryDate.periods.isNotEmpty) _buildPeriods(deliveryDate),
        ],
      ),
    );
  }

  Widget _buildPeriods(DeliveryDate deliveryDate) {
    return SeparatedColumn(
      children: deliveryDate.periods.map((period) {
        return _PeriodButton(
          onPressed: () {
            setState(() {
              widget.onSelected?.call(
                _selectedDate = DeliveryTime(
                  date: deliveryDate.date,
                  period: period,
                ),
              );
            });
          },
          selected: _selectedDate?.period == period,
          available: deliveryDate.available,
          period: period,
        );
      }).toList(growable: false),
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
        border: const Border.fromBorderSide(defaultBorder),
        color: AppColors.white,
      ),
      height: 48.0,
      child: Center(
        child: WaterText(
          '$formattedStartDate - $formattedEndTime',
          maxLines: 1,
          fontSize: 15.0,
          lineHeight: 1.25,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w700,
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
            color: selected ? AppColors.primary : AppColors.primaryLight,
          ),
          color: selected ? AppColors.primary : AppColors.primaryLight,
        ),
        height: 48.0,
        child: Center(
          child: WaterText(
            '$formattedStartDate - $formattedEndTime',
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
