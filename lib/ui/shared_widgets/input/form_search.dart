part of form_fields;

const double _searchIconSize = 24.0;

class WaterFormSearch extends StatefulWidget {
  const WaterFormSearch({
    Key? key,
    this.hintText,
  }) : super(key: key);

  final String? hintText;

  @override
  WaterFormSearchState createState() => WaterFormSearchState();
}

class WaterFormSearchState<T> extends State<WaterFormSearch>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();

  String get value => _textController.value.text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _textController,
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
        ),
      ],
    );
  }

  void reset() {
    _textController.clear();
  }

  Widget _buildSearchIcon() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: Icon(
        Icons.search,
        color: AppColors.borderColor,
        size: _searchIconSize,
      ),
    );
  }
}
