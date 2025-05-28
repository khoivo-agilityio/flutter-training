import 'package:flutter/material.dart';

class PfSearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Future<List<String>> Function(String query)? onSearchSubmit;
  final Widget? prefixIcon;
  final bool showClearButton;
  final InputDecoration? decoration;
  final TextStyle? style;

  const PfSearchTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onSearchSubmit,
    this.prefixIcon,
    this.showClearButton = true,
    this.decoration,
    this.style,
  });

  @override
  State<PfSearchTextField> createState() => _PfSearchTextFieldState();
}

class _PfSearchTextFieldState extends State<PfSearchTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  List<String> _suggestions = [];
  bool _showSuggestions = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 200), () {
          setState(() {
            _showSuggestions = false;
          });
        });
      }
    });
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
    setState(() {
      _suggestions = [];
      _showSuggestions = false;
    });
  }

  Future<void> _handleSubmit(String value) async {
    widget.onSubmitted?.call(value);

    if (widget.onSearchSubmit != null) {
      setState(() {
        _loading = true;
        _suggestions = [];
        _showSuggestions = true;
      });

      final result = await widget.onSearchSubmit!(value);

      setState(() {
        _suggestions = result;
        _loading = false;
        _showSuggestions = result.isNotEmpty;
      });
    }
  }

  void _selectSuggestion(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.collapsed(offset: suggestion.length);
    widget.onSubmitted?.call(suggestion);
    widget.onChanged?.call(suggestion);
    setState(() {
      _showSuggestions = false;
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputField = TextField(
      controller: _controller,
      focusNode: _focusNode,
      style: widget.style,
      decoration: widget.decoration ??
          InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon ?? const Icon(Icons.search),
            suffixIcon: widget.showClearButton && _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearText,
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
      onChanged: widget.onChanged,
      onSubmitted: _handleSubmit,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        inputField,
        if (_showSuggestions)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _loading
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      return ListTile(
                        title: Text(suggestion),
                        onTap: () => _selectSuggestion(suggestion),
                      );
                    },
                  ),
          ),
      ],
    );
  }
}
