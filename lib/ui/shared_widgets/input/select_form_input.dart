import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/text_style.dart';
import 'package:water/ui/icons/app_icons.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

const int _errorMaxLines = 3;
const double _fontSize = 15.0;
const double _lineHeight = 1.5;
const double _labelFontSize = 15.0;
const double _errorFontSize = 14.0;
const double _borderRadius = 19.0;
const double _borderWidth = 1.0;
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

class SelectFormInput extends StatefulWidget {
  const SelectFormInput({
    Key? key,
    this.readOnly = false,
    this.validator,
    this.initialValue,
    this.labelText,
  }) : super(key: key);

  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;

  @override
  SelectFormInputState createState() => SelectFormInputState();
}

class SelectFormInputState extends State<SelectFormInput>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  late final AnimationController _animationController;
  late final Animation<double> _turnsAnimation;
  late final Animation<double> _opacityAnimation;

  late OverlayEntry _dropdownButtons;

  List<String> items = [
    'Label 1',
    'Label 2',
    'Label 3',
    'Label 4',
    'Label 5',
    'Label 6',
  ];

  String get value => _textController.value.text;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _focusNode.addListener(_handleInputFocus);
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
        CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            readOnly: true,
            focusNode: _focusNode,
            controller: _textController,
            validator: widget.validator,
            initialValue: widget.initialValue,
            cursorColor: AppColors.primary,
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
              hintText: widget.labelText,
              hintStyle: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: _labelFontSize,
                fontWeight: FontWeight.w500,
              ).poppins,
              errorStyle: const TextStyle(
                color: AppColors.errorText,
                fontSize: _errorFontSize,
                fontWeight: FontWeight.w600,
              ).poppins,
              errorMaxLines: _errorMaxLines,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            autovalidateMode: AutovalidateMode.disabled,
          ),
        ),
      ],
    );
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _turnsAnimation = Tween<double>(
      begin: 0.0,
      end: -0.5,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  void _handleInputFocus() {
    if (_focusNode.hasFocus) {
      _createDropdownButtons();
      _animationController.forward();
    } else {
      _animationController.reverse();
      _dropdownButtons.remove();
    }
  }

  void _createDropdownButtons() {
    final renderBox = context.findRenderObject() as RenderBox;

    final dropdownButtons = OverlayEntry(
      builder: (_) => items.isNotEmpty
          ? Positioned(
              width: renderBox.size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, renderBox.size.height),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    child: Container(
                      height: 48.0 * 4.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        border: Border.all(color: AppColors.borderColor),
                        color: AppColors.white,
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: items.map(_buildItem).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );

    Overlay.of(context)?.insert(_dropdownButtons = dropdownButtons);
  }

  Widget _buildItem(String item) {
    return GestureDetector(
      onTap: () {
        _textController.text = item;
        _animationController.reverse();
        _focusNode.unfocus();
      },
      child: Container(
        height: 48.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: WaterText(
            item,
            lineHeight: 1.5,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
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
          color: AppColors.secondaryText,
          size: 21.0,
        ),
      ),
    );
  }
}
