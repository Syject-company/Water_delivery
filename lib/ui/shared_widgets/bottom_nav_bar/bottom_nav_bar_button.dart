part of 'bottom_nav_bar.dart';

const double _iconSize = 26.0;
const Color _selectedIconColor = Colors.white;
const Color _unselectedIconColor = AppColors.primaryTextColor;
const BorderRadiusGeometry _borderRadius =
    BorderRadius.all(Radius.circular(15.0));

class BottomNavBarButton extends StatefulWidget {
  const BottomNavBarButton({
    Key? key,
    required this.icon,
    required this.selectedIcon,
    this.selected = false,
  }) : super(key: key);

  final Widget icon;
  final Widget selectedIcon;
  final bool selected;

  @override
  BottomNavBarButtonState createState() => BottomNavBarButtonState();
}

class BottomNavBarButtonState extends State<BottomNavBarButton> {
  late bool _selected = widget.selected;

  set selected(bool selected) {
    setState(() => _selected = selected);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: _selected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: _borderRadius,
        ),
        child: IconTheme(
          data: IconThemeData(
            size: _iconSize,
            color: _selected ? _selectedIconColor : _unselectedIconColor,
          ),
          child: _selected ? widget.selectedIcon : widget.icon,
        ),
      ),
    );
  }
}
