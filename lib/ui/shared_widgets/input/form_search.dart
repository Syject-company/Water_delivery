part of form_fields;

const double _searchIconSize = 28.0;

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

  String get value => _textController.value.text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      onChanged: widget.onChanged,
      style: const TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      ).nunitoSans,
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
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ).nunitoSans,
      ),
      autovalidateMode: AutovalidateMode.disabled,
      enableInteractiveSelection: false,
    );
  }

  void reset() {
    _textController.clear();
  }

  Widget _buildSearchIcon() {
    return Icon(
      AppIcons.search,
      color: AppColors.secondaryText,
      size: _searchIconSize,
    ).withPadding(0.0, 0.0, 12.0, 0.0);
  }
}
