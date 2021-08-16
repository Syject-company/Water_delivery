import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/water.dart';

part 'bottom_navigation_bar_item.dart';

typedef SelectCallback = void Function(int index);

const double _iconSize = 32.0;
const Color _selectedIconColor = AppColors.white;
const Color _unselectedIconColor = AppColors.primaryText;
const double _borderRadius = 15.0;

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
        border: Border(top: defaultBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildButtons(),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return items
        .asMap()
        .map((index, item) {
          return MapEntry(
            index,
            GestureDetector(
              onTap: () {
                if (item.selectable) {
                  onSelected?.call(index);
                }
                item.onPressed?.call();
              },
              child: _WaterBottomNavigationBarButton(
                key: ValueKey(item),
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                selected: item.selectable && index == selectedIndex,
              ),
            ),
          );
        })
        .values
        .toList();
  }
}

class _WaterBottomNavigationBarButton extends StatefulWidget {
  const _WaterBottomNavigationBarButton({
    Key? key,
    required this.icon,
    required this.selectedIcon,
    this.selected = false,
  }) : super(key: key);

  final Widget icon;
  final Widget selectedIcon;
  final bool selected;

  @override
  _WaterBottomNavigationBarButtonState createState() =>
      _WaterBottomNavigationBarButtonState();
}

class _WaterBottomNavigationBarButtonState
    extends State<_WaterBottomNavigationBarButton> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: widget.selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: IconTheme(
          data: IconThemeData(
            size: _iconSize,
            color: widget.selected ? _selectedIconColor : _unselectedIconColor,
          ),
          child: widget.selected ? widget.selectedIcon : widget.icon,
        ),
      ),
    );
  }
}
