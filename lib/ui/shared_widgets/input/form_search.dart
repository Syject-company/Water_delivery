part of form_fields;

const double _searchIconSize = 24.0;

class WaterFormSearch extends StatefulWidget {
  const WaterFormSearch({
    Key? key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  final String? hintText;
  final void Function(String)? onChanged;

  @override
  WaterFormSearchState createState() => WaterFormSearchState();
}

class WaterFormSearchState<T> extends State<WaterFormSearch>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late Color _suffixIconColor = _getActiveColor();

  String get value => _textController.value.text;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _suffixIconColor = _getActiveColor());
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _textController,
      onChanged: widget.onChanged,
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
        suffixIcon: _buildSearchIcon(),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          height: _lineHeight,
          fontSize: _hintFontSize,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
        ).poppins,
      ),
      autovalidateMode: AutovalidateMode.disabled,
      enableInteractiveSelection: false,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void reset() {
    _textController.clear();
  }

  Widget _buildSearchIcon() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: Icon(
        Icons.search,
        color: _suffixIconColor,
        size: _searchIconSize,
      ),
    );
  }

  Color _getActiveColor() {
    if (_focusNode.hasFocus) {
      return AppColors.primary;
    }
    return AppColors.secondaryText;
  }
}
