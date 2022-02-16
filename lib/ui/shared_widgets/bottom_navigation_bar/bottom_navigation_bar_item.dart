part of 'bottom_navigation_bar.dart';

class WaterBottomNavigationBarItem {
  const WaterBottomNavigationBarItem({
    required this.icon,
    required this.selectedIcon,
    this.enabled = true,
    this.selectable = true,
    this.onPressed,
  });

  final Widget icon;
  final Widget selectedIcon;
  final bool enabled;
  final bool selectable;
  final VoidCallback? onPressed;
}
