import 'package:flutter/material.dart';

const double appBarHeight = 72.0;

const double _actionsSpaceBetween = 16.0;
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
      centerTitle: true,
      actions: _buildActionsButtons(),
      elevation: _elevation,
      toolbarHeight: appBarHeight,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
    );
  }

  List<Widget> _buildActionsButtons() {
    final buttons = <Widget>[];

    actions?.forEach((action) {
      buttons.addAll([
        if (action == actions?.first)
          const SizedBox(width: _actionsSpaceBetween),
        action,
        const SizedBox(width: _actionsSpaceBetween),
      ]);
    });

    return buttons;
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
