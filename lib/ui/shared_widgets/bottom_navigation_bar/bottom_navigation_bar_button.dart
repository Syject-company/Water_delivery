part of 'bottom_navigation_bar.dart';

const double _iconSize = 26.0;
const Color _selectedIconColor = AppColors.white;
const Color _unselectedIconColor = AppColors.primaryText;
const double _borderRadius = 15.0;

class WaterBottomNavigationBarButton extends StatefulWidget {
  const WaterBottomNavigationBarButton({
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
    extends State<WaterBottomNavigationBarButton> {
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
