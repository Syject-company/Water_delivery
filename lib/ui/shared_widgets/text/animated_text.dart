import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class AnimatedWaterText extends StatefulWidget {
  const AnimatedWaterText(
    this.text, {
    Key? key,
    this.fontSize = 15.0,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.w600,
    this.color = AppColors.primaryText,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 375),
    this.softWrap,
    this.lineHeight,
    this.maxLines,
    this.overflow,
    this.decoration,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final Color color;
  final AlignmentGeometry alignment;
  final bool? softWrap;
  final double? lineHeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Duration duration;

  @override
  AnimatedWaterTextState createState() => AnimatedWaterTextState();
}

class AnimatedWaterTextState extends State<AnimatedWaterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final CurvedAnimation _curvedAnimation;

  late String _oldValue = widget.text;
  late String _newValue = widget.text;

  bool _isReversed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() => setState(() {}));
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.alignment,
      children: <Widget>[
        if (!_isReversed)
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, -0.75),
              end: Offset(0.0, 0.0),
            ).animate(_curvedAnimation),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(_curvedAnimation),
              child: _buildText(_newValue),
            ),
          ),
        SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, _isReversed ? -0.75 : 0.75),
          ).animate(_curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 1.0,
              end: 0.0,
            ).animate(_curvedAnimation),
            child: _buildText(_oldValue),
          ),
        ),
        if (_isReversed)
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 0.75),
              end: Offset(0.0, 0.0),
            ).animate(_curvedAnimation),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(_curvedAnimation),
              child: _buildText(_newValue),
            ),
          ),
      ],
    );
  }

  void setNewValue(String value, {bool reverse = false}) {
    _isReversed = reverse;
    _oldValue = _newValue;
    _newValue = value;
    _animationController.forward(from: 0.0);
  }

  Widget _buildText(String text) {
    return WaterText(
      text,
      fontSize: widget.fontSize,
      fontWeight: widget.fontWeight,
      textAlign: widget.textAlign,
      color: widget.color,
      softWrap: widget.softWrap,
      lineHeight: widget.lineHeight,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      decoration: widget.decoration,
    );
  }
}
