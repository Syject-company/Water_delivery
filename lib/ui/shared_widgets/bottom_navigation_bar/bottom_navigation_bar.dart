import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';

part 'bottom_navigation_bar_button.dart';
part 'bottom_navigation_bar_item.dart';

typedef SelectCallback = void Function(int index);

const double bottomNavigationBarHeight = 80.0;
const EdgeInsetsGeometry _contentPadding =
    EdgeInsets.symmetric(vertical: 12.0, horizontal: 36.0);

class WaterBottomNavigationBar extends StatelessWidget {
  WaterBottomNavigationBar({
    Key? key,
    required this.items,
    this.selectedIndex,
    this.onSelected,
  }) : super(key: key);

  final List<WaterBottomNavigationBarItem> items;
  final int? selectedIndex;
  final SelectCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _contentPadding,
      height: bottomNavigationBarHeight,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtons(),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return items
        .asMap().map((index, item) {
          return MapEntry(
            index,
            GestureDetector(
              onTap: () {
                if (item.selectable) {
                  onSelected?.call(index);
                }
                item.onPressed?.call();
              },
              child: WaterBottomNavigationBarButton(
                key: ValueKey(item),
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                selected: index == selectedIndex,
              ),
            ),
          );
        }).values.toList();
  }
}
