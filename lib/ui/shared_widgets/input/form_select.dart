part of form_fields;

const double _itemHeight = 48.0;

class WaterFormSelect extends StatefulWidget {
  const WaterFormSelect({
    Key? key,
    required this.items,
    this.controller,
    this.validator,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.helpText,
    this.onChanged,
    this.enableSearch = true,
  }) : super(key: key);

  final List<String> items;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final String? helpText;
  final bool enableSearch;
  final void Function(String)? onChanged;

  @override
  WaterFormSelectState createState() => WaterFormSelectState();
}

class WaterFormSelectState extends State<WaterFormSelect>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();

  late final TextEditingController _textController =
      widget.controller ?? TextEditingController(text: widget.initialValue);

  String? get value =>
      _textController.text.isNotEmpty ? _textController.text : null;

  late List<String> _items = widget.items;

  @override
  Widget build(BuildContext context) {
    return widget.labelText != null
        ? _wrapWithLabel(_buildFormSelect())
        : _buildFormSelect();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void setItems(List<String> items, {bool reset = true}) {
    if (reset) {
      _textController.clear();
    }
    setState(() => _items = items);
  }

  Widget _buildFormSelect() {
    return TextFormField(
      readOnly: true,
      focusNode: _focusNode,
      controller: _textController,
      validator: widget.validator,
      enabled: _items.isNotEmpty,
      onTap: () {
        _focusNode.unfocus();
        _showSelectDialog();
      },
      style: const TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryText,
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
        hintStyle: TextStyle(
          height: _lineHeight,
          fontSize: _hintFontSize,
          fontWeight: FontWeight.w500,
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableInteractiveSelection: false,
    );
  }

  Widget _wrapWithLabel(Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
          child: WaterText(
            widget.labelText!,
            maxLines: 1,
            fontSize: 15.0,
            lineHeight: 1.25,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildArrowIcon() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: Icon(
        AppIcons.arrow_down,
        color: _items.isNotEmpty ? AppColors.secondaryText : AppColors.disabled,
        size: 32.0,
      ),
    );
  }

  Future<void> _showSelectDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return _SelectDialog(
          items: _items,
          helpText: widget.helpText,
          enableSearch: widget.enableSearch,
          currentValue: _textController.text,
          onSelected: (item) {
            widget.onChanged?.call(item);
            _textController.text = item;

            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _SelectDialog extends StatefulWidget {
  const _SelectDialog({
    Key? key,
    required this.items,
    this.enableSearch = true,
    this.currentValue,
    this.helpText,
    this.onSelected,
  }) : super(key: key);

  final List<String> items;
  final bool enableSearch;
  final String? currentValue;
  final String? helpText;
  final void Function(String)? onSelected;

  @override
  _SelectDialogState createState() => _SelectDialogState();
}

class _SelectDialogState extends State<_SelectDialog> {
  late List<String> searchedItems = widget.items;

  @override
  Widget build(BuildContext context) {
    final containsHelpText = widget.helpText != null;
    final scrollController = ScrollController();

    return AlertDialog(
      elevation: 0.0,
      titlePadding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
      contentPadding: EdgeInsetsDirectional.fromSTEB(
          12.0, containsHelpText ? 0.0 : 24.0, 6.0, 24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      title: containsHelpText
          ? WaterText(
              widget.helpText!.toUpperCase(),
              fontSize: 15.0,
              lineHeight: 1.25,
            )
          : null,
      content: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 1.5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.enableSearch)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12.0, end: 18.0),
                    child: WaterFormSearch(
                      hintText: 'input.search'.tr(),
                      onChanged: (value) {
                        setState(() {
                          searchedItems = widget.items.where((item) {
                            return _containsIgnoreCase(item, value);
                          }).toList();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 18.0),
                ],
              ),
            Flexible(
              child: RawScrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                thumbColor: AppColors.primary,
                radius: Radius.circular(15.0),
                thickness: 3.0,
                child: ListView.builder(
                  padding:
                      const EdgeInsetsDirectional.only(start: 12.0, end: 18.0),
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: searchedItems.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return _buildItem(searchedItems[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String item) {
    final selected = item == widget.currentValue;

    return GestureDetector(
      onTap: () {
        widget.onSelected?.call(item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: selected ? AppColors.primary : AppColors.white,
        ),
        height: _itemHeight,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: WaterText(
            item,
            fontSize: _fontSize,
            lineHeight: 1.25,
            fontWeight: FontWeight.w500,
            color: selected ? AppColors.white : AppColors.primaryText,
          ),
        ),
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  bool _containsIgnoreCase(String a, String b) {
    return a.toLowerCase().contains(b.toLowerCase());
  }
}
