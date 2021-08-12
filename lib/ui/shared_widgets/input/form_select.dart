part of form_fields;

const double _itemHeight = 48.0;

class WaterFormSelect<T> extends StatefulWidget {
  const WaterFormSelect({
    Key? key,
    required this.items,
    this.validator,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.helpText,
    this.onChanged,
    this.enableSearch = true,
  }) : super(key: key);

  final Map<T, String> items;
  final FormFieldValidator<String>? validator;
  final T? initialValue;
  final String? labelText;
  final String? hintText;
  final String? helpText;
  final bool enableSearch;
  final void Function(T)? onChanged;

  @override
  WaterFormSelectState<T> createState() => WaterFormSelectState<T>();
}

class WaterFormSelectState<T> extends State<WaterFormSelect<T>>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();

  late final TextEditingController _textController;

  late MapEntry<T, String>? _selectedValue;

  Map<T, String> get _items => widget.items;

  String get value => _selectedValue?.value ?? '';

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: _items[widget.initialValue],
    );
    _selectedValue = _items.entries.firstWhereOrNull(
      (entry) => entry.key == widget.initialValue,
    );
  }

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

  void reset() {
    _textController.clear();
    _selectedValue = null;
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableInteractiveSelection: false,
    );
  }

  Widget _wrapWithLabel(Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
          child: WaterText(
            widget.labelText!,
            maxLines: 1,
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
        return _SelectDialog<T>(
          items: _items,
          initialValue: _selectedValue,
          helpText: widget.helpText,
          enableSearch: widget.enableSearch,
          onSelected: (entry) {
            widget.onChanged?.call(entry.key);
            _textController.text = entry.value;
            _selectedValue = entry;

            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _SelectDialog<T> extends StatefulWidget {
  const _SelectDialog({
    Key? key,
    required this.items,
    this.enableSearch = true,
    this.initialValue,
    this.helpText,
    this.onSelected,
  }) : super(key: key);

  final Map<T, String> items;
  final bool enableSearch;
  final MapEntry<T, String>? initialValue;
  final String? helpText;
  final void Function(MapEntry<T, String>)? onSelected;

  @override
  _SelectDialogState<T> createState() => _SelectDialogState<T>();
}

class _SelectDialogState<T> extends State<_SelectDialog<T>> {
  late Map<T, String> searchedItems = widget.items;

  @override
  Widget build(BuildContext context) {
    final containsHelpText = widget.helpText != null;
    final scrollController = ScrollController();
    final items = searchedItems.entries.toList();

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
          children: <Widget>[
            if (widget.enableSearch)
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12.0, end: 18.0),
                    child: WaterFormSearch(
                      hintText: 'input.search'.tr(),
                      onChanged: (value) {
                        setState(() {
                          searchedItems = {
                            for (final entry in widget.items.entries.where(
                                (entry) =>
                                    _containsIgnoreCase(entry.value, value)))
                              entry.key: entry.value
                          };
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
  }

  Widget _buildItem(BuildContext context, MapEntry<T, String> item) {
    final selected = item.key == widget.initialValue?.key;

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
            item.value,
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

  bool _containsIgnoreCase(String a, String b) =>
      a.toLowerCase().contains(b.toLowerCase());
}
