part of form_fields;

const double _itemHeight = 48.0;

class WaterFormSelect<T> extends StatefulWidget {
  const WaterFormSelect({
    Key? key,
    required this.items,
    this.validator,
    this.initialValue,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  final Map<T, String> items;
  final FormFieldValidator<String>? validator;
  final T? initialValue;
  final String? hintText;
  final void Function(T)? onChanged;

  @override
  WaterFormSelectState<T> createState() => WaterFormSelectState<T>();
}

class WaterFormSelectState<T> extends State<WaterFormSelect<T>>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Color _iconColor = AppColors.secondaryText;

  late MapEntry<T, String>? selectedValue = widget.items.entries
      .firstWhereOrNull((entry) => entry.key == widget.initialValue);

  String get value => _textController.value.text;

  @override
  void dispose() {
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
          enabled: widget.items.isNotEmpty,
          initialValue: selectedValue?.value,
          onTap: () {
            _focusNode.unfocus();
            _showDropdown();
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
      ],
    );
  }

  void reset() {
    _textController.clear();
  }

  Widget _buildArrowIcon() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: Icon(
        AppIcons.arrow_down,
        color: _iconColor,
        size: _iconSize,
      ),
    );
  }

  Future<DateTime?> _showDropdown() async {
    final scrollController = ScrollController();
    final items = widget.items.entries.toList();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0.0,
          insetPadding: const EdgeInsets.all(24.0),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          contentPadding:
              const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 6.0, 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          title: WaterText('Select Nationality'.toUpperCase()),
          content: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 1.5,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 18.0),
                  child: WaterFormSearch(
                    hintText: 'Search...',
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: RawScrollbar(
                    isAlwaysShown: true,
                    controller: scrollController,
                    thumbColor: AppColors.primary,
                    radius: Radius.circular(_borderRadius),
                    thickness: 3.0,
                    child: ListView.builder(
                      padding: const EdgeInsetsDirectional.only(
                          start: 8.0, end: 26.0),
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      itemCount: items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _buildItem(context, items[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, MapEntry<T, String> item) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(item.key);
        _textController.text = item.value;
        Navigator.of(context).pop();
      },
      child: SizedBox(
        height: _itemHeight,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: WaterText(
            item.value,
            fontSize: _fontSize,
            lineHeight: _lineHeight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      behavior: HitTestBehavior.opaque,
    );
  }
}
