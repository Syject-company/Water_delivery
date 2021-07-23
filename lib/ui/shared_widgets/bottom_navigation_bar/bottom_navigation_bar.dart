import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

part 'bottom_navigation_bar_button.dart';
part 'bottom_navigation_bar_item.dart';

typedef SelectCallback = void Function(int index);

const double _bottomNavBarHeight = 80.0;
const EdgeInsetsGeometry _contentPadding =
    EdgeInsets.symmetric(vertical: 12.0, horizontal: 36.0);

class WaterBottomNavigationBar extends StatelessWidget {
  WaterBottomNavigationBar({
    Key? key,
    required this.onSelected,
    required this.items,
    this.currentIndex = 0,
  }) : super(key: key);

  final SelectCallback onSelected;
  final List<WaterBottomNavigationBarItem> items;
  final int currentIndex;
  final List<GlobalKey<WaterBottomNavigationBarButtonState>> _buttonsKeys = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _contentPadding,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
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
      final buttonKey = GlobalKey<WaterBottomNavigationBarButtonState>();
      _buttonsKeys.add(buttonKey);

      buttons.add(
        GestureDetector(
          onTap: () {
            if (item.selectable) {
              _buttonsKeys.where((key) => key != buttonKey).forEach((key) {
                key.currentState!.selected = false;
              });
              buttonKey.currentState!.selected = true;
              onSelected(index);
            }

            if (item.onPressed != null) {
              item.onPressed!();
            }
          },
          child: WaterBottomNavigationBarButton(
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
