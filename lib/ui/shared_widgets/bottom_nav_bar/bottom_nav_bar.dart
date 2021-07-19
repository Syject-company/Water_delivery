import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

part 'bottom_nav_bar_button.dart';
part 'bottom_nav_bar_item.dart';

typedef SelectCallback = void Function(int index);

const double _bottomNavBarHeight = 96.0;
const EdgeInsetsGeometry _contentPadding =
    EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0);

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    Key? key,
    required this.onSelected,
    required this.items,
    this.currentIndex = 0,
  }) : super(key: key);

  final SelectCallback onSelected;
  final List<BottomNavBarItem> items;
  final int currentIndex;
  final List<GlobalKey<BottomNavBarButtonState>> _buttonsKeys = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _contentPadding,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      height: _bottomNavBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtons(),
      ),
    );
  }

  List<Widget> _buildButtons() {
    final buttons = <Widget>[];

    items.asMap().forEach((index, item) {
      final buttonKey = GlobalKey<BottomNavBarButtonState>();
      _buttonsKeys.add(buttonKey);

      buttons.add(
        GestureDetector(
          onTap: () {
            _buttonsKeys.where((key) => key != buttonKey).forEach((key) {
              key.currentState!.selected = false;
            });
            buttonKey.currentState!.selected = true;
            onSelected(index);
          },
          child: BottomNavBarButton(
            key: buttonKey,
            icon: item.icon,
            selectedIcon: item.selectedIcon,
            selected: index == currentIndex,
          ),
        ),
      );
    });

    return buttons;
  }
}
