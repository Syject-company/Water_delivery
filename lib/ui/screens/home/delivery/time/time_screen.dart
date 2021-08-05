import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/screens/home/delivery/delivery_navigator.dart';
import 'package:water/ui/shared_widgets/app_bar.dart';
import 'package:water/ui/shared_widgets/button/app_bar_back_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_icon_button.dart';
import 'package:water/ui/shared_widgets/button/app_bar_notification_button.dart';
import 'package:water/ui/shared_widgets/button/button.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class TimeScreen extends StatefulWidget {
  TimeScreen({Key? key}) : super(key: key);

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 24.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            WaterText(
              'Select a convenient delivery time for your district',
              lineHeight: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
            const SizedBox(height: 24.0),
            Flexible(child: PeriodPicker()),
            const SizedBox(height: 24.0),
            WaterText(
              'Selected time:',
              fontSize: 18.0,
              lineHeight: 2.0,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            WaterText(
              'December 27',
              fontSize: 18.0,
              lineHeight: 2.0,
              textAlign: TextAlign.center,
              color: AppColors.secondaryText,
            ),
            WaterText(
              '12h - 15h',
              fontSize: 18.0,
              lineHeight: 2.0,
              textAlign: TextAlign.center,
              color: AppColors.secondaryText,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNextButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return WaterAppBar(
      title: WaterText(
        'Time',
        fontSize: 24.0,
        textAlign: TextAlign.center,
      ),
      leading: AppBarBackButton(
        onPressed: () => deliveryNavigator.pop(),
      ),
      actions: <Widget>[
        AppBarIconButton(
          onPressed: () {},
          icon: AppIcons.whatsapp,
        ),
        AppBarNotificationButton(),
      ],
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: WaterButton(
        onPressed: () {},
        text: 'button.next'.tr(),
      ),
    );
  }
}

class PeriodPicker extends StatefulWidget {
  const PeriodPicker({Key? key}) : super(key: key);

  @override
  _PeriodPickerState createState() => _PeriodPickerState();
}

class _PeriodPickerState extends State<PeriodPicker> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _buildPeriodItem(items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: 10.0);
      },
      itemCount: items.length,
    );
  }

  Widget _buildPeriodItem(PeriodItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.0),
        border: Border.all(color: AppColors.borderColor),
        color: AppColors.white,
      ),
      width: 108.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WaterText(
            'Today',
            fontSize: 15.0,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
            color: AppColors.secondaryText,
          ),
          const SizedBox(height: 6.0),
          WaterText(
            '28/12',
            fontSize: 20.0,
            lineHeight: 2.0,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12.0),
          // _buildPeriods(item.periods),
        ],
      ),
    );
  }

  Widget _buildPeriods(List<Period> periods) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return PeriodButton();
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10.0);
      },
      shrinkWrap: true,
      itemCount: periods.length,
    );
  }
}

final List<PeriodItem> items = [
  PeriodItem(
    date: DateTime.now(),
    periods: <Period>[
      Period(
        id: '1',
        startTime: 8,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '2',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
  PeriodItem(
    date: DateTime.now().add(Duration(days: 1)),
    periods: <Period>[
      Period(
        id: '3',
        startTime: 8,
        endTime: 13,
        available: true,
      ),
      Period(
        id: '4',
        startTime: 13,
        endTime: 8,
        available: false,
      ),
    ],
  ),
  PeriodItem(
    date: DateTime.now().add(Duration(days: 2)),
    periods: <Period>[
      Period(
        id: '5',
        startTime: 8,
        endTime: 13,
        available: false,
      ),
      Period(
        id: '6',
        startTime: 13,
        endTime: 8,
        available: true,
      ),
    ],
  ),
];

class PeriodItem {
  const PeriodItem({
    required this.date,
    required this.periods,
  });

  final DateTime date;
  final List<Period> periods;
}

class Period {
  const Period({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.available,
  });

  final String id;
  final double startTime;
  final double endTime;
  final bool available;
}

// class PeriodGroup extends StatefulWidget {
//   PeriodGroup({
//     Key? key,
//     required this.values,
//     required this.onChanged,
//     this.currentValue,
//     this.mainAxisAlignment = MainAxisAlignment.center,
//     this.spaceBetween = 16.0,
//     this.labelFontSize,
//     this.labelLineHeight,
//   })  : assert(spaceBetween >= 0.0),
//         super(key: key);
//
//   final Map<T, String> values;
//   final ValueChanged<T> onChanged;
//   final T? currentValue;
//   final Axis axis;
//   final MainAxisAlignment mainAxisAlignment;
//   final double spaceBetween;
//   final double? labelFontSize;
//   final double? labelLineHeight;
//
//   @override
//   _PeriodGroupState createState() => _PeriodGroupState();
// }

// class _PeriodGroupState extends State<PeriodGroup> {
// late E? _selectedValue = widget.currentValue;
//
// @override
// Widget build(BuildContext context) {
//   return Column(
//     mainAxisAlignment: widget.mainAxisAlignment,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: _buildPeriodButtons(),
//   );
// }

// List<Widget> _buildPeriodButtons() {
//   final buttons = <Widget>[];
//
//   widget.values.forEach((value, label) {
//     buttons.add(
//       GestureDetector(
//         onTap: () {
//           if (_selectedValue != value) {
//             setState(() => _selectedValue = value);
//             widget.onChanged(_selectedValue!);
//           }
//         },
//         child: WaterRadioButton(
//           label: label,
//           selected: _selectedValue != null && _selectedValue == value,
//           labelFontSize: widget.labelFontSize,
//           labelLineHeight: widget.labelLineHeight,
//         ),
//         behavior: HitTestBehavior.opaque,
//       ),
//     );
//
//     if (value != widget.values.keys.last) {
//       buttons.add(widget.axis == Axis.vertical
//           ? SizedBox(height: widget.spaceBetween)
//           : SizedBox(width: widget.spaceBetween));
//     }
//   });
//
//   return buttons;
// }
// }

class PeriodButton extends StatelessWidget {
  const PeriodButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColors.borderColor),
        color: AppColors.white,
      ),
      height: 45.0,
      child: Center(
        child: WaterText(
          '8h - 12h',
          maxLines: 1,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
