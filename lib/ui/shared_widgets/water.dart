library water;

import 'package:flutter/material.dart';
import 'package:water/app_colors.dart';

export 'package:water/app_colors.dart';
export 'package:water/ui/extensions/num.dart';
export 'package:water/ui/extensions/widget.dart';
export 'package:water/ui/icons/app_icons.dart';
export 'package:water/util/sizer.dart';

export 'app_bar.dart';
export 'bottom_navigation_bar/bottom_navigation_bar.dart';
export 'button/app_bar_back_button.dart';
export 'button/app_bar_icon_button.dart';
export 'button/app_bar_notification_button.dart';
export 'button/app_bar_whatsapp_button.dart';
export 'button/button.dart';
export 'button/circle_button.dart';
export 'button/icon_button.dart';
export 'button/secondary_button.dart';
export 'carousel_slider/carousel_slider.dart';
export 'dialog/dialog.dart';
export 'gradient_icon.dart';
export 'input/form_fields.dart';
export 'loader_overlay.dart';
export 'logo/animated_logo.dart';
export 'logo/logo.dart';
export 'number_picker.dart';
export 'radio/radio_group.dart';
export 'shimmer.dart';
export 'side_menu.dart';
export 'text/text.dart';
export 'toast.dart';

const Widget defaultDivider = Divider(
  color: AppColors.borderColor,
  thickness: 1.0,
  height: 1.0,
);

const BorderSide defaultBorder = BorderSide(
  color: AppColors.borderColor,
  width: 1.0,
);
