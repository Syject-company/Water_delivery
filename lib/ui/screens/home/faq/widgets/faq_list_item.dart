import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

class FAQListItem extends StatefulWidget {
  const FAQListItem({
    Key? key,
    required this.header,
    required this.body,
  }) : super(key: key);

  final String header;
  final String body;

  @override
  FAQListItemState createState() => FAQListItemState();
}

class FAQListItemState extends State<FAQListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (_isExpanded = !_isExpanded)
            ? _animationController.forward()
            : _animationController.reverse();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          _buildBody(),
        ],
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return WaterText(
      widget.header,
      fontSize: 16.0,
      lineHeight: 1.5,
      fontWeight: FontWeight.w700,
      textAlign: TextAlign.center,
      color: AppColors.primary,
    ).withPadding(24.0, 18.0, 24.0, 18.0);
  }

  Widget _buildBody() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOutCubic,
            ),
          ),
          child: SizeTransition(
            axisAlignment: -1.0,
            sizeFactor: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOutCubic,
              ),
            ),
            child: child!,
          ),
        );
      },
      child: WaterText(
        widget.header,
        fontSize: 15.0,
        lineHeight: 1.5,
        fontWeight: FontWeight.w400,
      ).withPadding(24.0, 0.0, 24.0, 18.0),
    );
  }
}
