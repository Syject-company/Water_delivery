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
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.0),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostedTime(),
              const SizedBox(height: 6.0),
              _buildBodyText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostedTime() {
    return WaterText(
      DateFormat('dd/MM/yyyy  hh:mm a').format(notification.postedTime),
      fontSize: 13.0,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
    );
  }

  Widget _buildBodyText() {
    return WaterText(
      notification.body,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
    );
  }
}
