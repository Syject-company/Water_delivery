import 'package:flutter/material.dart';

const double appBarHeight = 72.0;
const double _elevation = 0.0;

class WaterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WaterAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      elevation: _elevation,
      toolbarHeight: appBarHeight,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
