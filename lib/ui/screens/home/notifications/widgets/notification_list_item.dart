import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water/domain/model/notification.dart' as water;
import 'package:water/ui/shared_widgets/water.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final water.Notification notification;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.0),
            border: Border.fromBorderSide(defaultBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostedDate(),
              _buildBodyText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostedDate() {
    final formattedPostedDate =
        DateFormat('dd/MM/yyyy  hh:mm a').format(notification.postedDate);

    return WaterText(
      formattedPostedDate,
      fontSize: 13.0,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildBodyText() {
    final body = notification.body;

    if (body != null && body.isNotEmpty) {
      return WaterText(
        body,
        fontSize: 15.0,
        lineHeight: 1.5,
        fontWeight: FontWeight.w500,
      ).withPadding(0.0, 6.0, 0.0, 0.0);
    }

    return const SizedBox.shrink();
  }
}
