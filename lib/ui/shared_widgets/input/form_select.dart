import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const int _errorMaxLines = 3;
const double _fontSize = 15.0;
const double _lineHeight = 1.5;
const double _hintFontSize = 15.0;
const double _errorFontSize = 14.0;
const double _borderRadius = 19.0;
const double _borderWidth = 1.0;
const double _iconSize = 18.0;
const double _itemHeight = 48.0;
const int _maxVisibleItems = 3;
const Duration _animationDuration = Duration(milliseconds: 250);
const EdgeInsetsGeometry _contentPadding =
    EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 12.0, 16.0);
const OutlineInputBorder _defaultBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputDefaultBorder,
    width: _borderWidth,
  ),
);
const OutlineInputBorder _focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputFocusedBorder,
    width: _borderWidth,
  ),
);
const OutlineInputBorder _errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
  borderSide: BorderSide(
    color: AppColors.inputErrorBorder,
    width: _borderWidth,
  ),
);

class WaterFormSelect extends StatefulWidget {
  const WaterFormSelect({
    Key? key,
    required this.items,
    this.validator,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  final List<String> items;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? hintText;

  @override
  WaterFormSelectState createState() => WaterFormSelectState();
}

class WaterFormSelectState extends State<WaterFormSelect>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late final AnimationController _animationController;
  late final Animation<double> _turnsAnimation;
  late final Animation<double> _sizeAnimation;

  Color _iconColor = AppColors.secondaryText;

  String get value => _textController.value.text;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _listenFocus();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          readOnly: true,
          focusNode: _focusNode,
          controller: _textController,
          validator: widget.validator,
          initialValue: widget.initialValue,
          onTap: () {
            if (_focusNode.hasFocus) {
              _animationController.reverse();
              _focusNode.unfocus();
            }
          },
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: _fontSize,
            fontWeight: FontWeight.w500,
          ).poppins,
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
            height: _lineHeight,
          ),
          decoration: InputDecoration(
            contentPadding: _contentPadding,
            enabledBorder: _defaultBorder,
            disabledBorder: _defaultBorder,
            focusedBorder: _focusedBorder,
            focusedErrorBorder: _errorBorder,
            errorBorder: _errorBorder,
            suffixIcon: _buildArrowIcon(),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              height: _lineHeight,
              fontSize: _hintFontSize,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryText,
            ).poppins,
            errorStyle: const TextStyle(
              height: _lineHeight,
              fontSize: _errorFontSize,
              fontWeight: FontWeight.w500,
              color: AppColors.errorText,
            ).poppins,
            errorMaxLines: _errorMaxLines,
          ),
          autovalidateMode: AutovalidateMode.disabled,
          enableInteractiveSelection: false,
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: _sizeAnimation,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_borderRadius),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: (_itemHeight * _maxVisibleItems) + 12.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius),
                border: Border.all(color: AppColors.borderColor),
                color: AppColors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: widget.items.map(_buildItem).toList(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _turnsAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
    _sizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  void _listenFocus() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.forward();
        setState(() => _iconColor = AppColors.primary);
      } else {
        _animationController.reverse();
        setState(() => _iconColor = AppColors.secondaryText);
      }
    });
  }

  Widget _buildItem(String item) {
    return GestureDetector(
      onTap: () {
        _textController.text = item;
        _animationController.reverse();
        _focusNode.unfocus();
      },
      child: Container(
        height: _itemHeight,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: WaterText(
            item,
            fontSize: _fontSize,
            lineHeight: _lineHeight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  Widget _buildArrowIcon() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: RotationTransition(
        turns: _turnsAnimation,
        child: Icon(
          AppIcons.arrow_down,
          color: _iconColor,
          size: _iconSize,
        ),
      ),
    );
  }
}
