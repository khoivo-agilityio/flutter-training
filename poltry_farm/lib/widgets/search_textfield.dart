import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';

class PfSearchTextField extends StatefulWidget {
  const PfSearchTextField({
    super.key,
    required this.controller,
    required this.suggestions,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onSuggestionSelected,
    this.focusNode,
    this.textInputAction = TextInputAction.search,
    this.semanticsLabel,
  });

  final TextEditingController controller;
  final List<String> suggestions;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function(String)? onSuggestionSelected;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final String? semanticsLabel;

  @override
  State<PfSearchTextField> createState() => _PfSearchTextFieldState();
}

class _PfSearchTextFieldState extends State<PfSearchTextField> {
  final _fieldKey = GlobalKey<FormFieldState>();
  List<String> filteredSuggestions = [];

  void _updateSuggestions(String input) {
    setState(() {
      filteredSuggestions = widget.suggestions
          .where((item) => item.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void _selectSuggestion(String value) {
    widget.controller.text = value;
    widget.onSuggestionSelected?.call(value);
    widget.onSubmitted?.call(value);
    setState(() {
      filteredSuggestions.clear();
    });
    widget.focusNode?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticsLabel ?? 'Search input',
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            key: _fieldKey,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            onChanged: (value) {
              _updateSuggestions(value);
              widget.onChanged?.call(value);
            },
            onSubmitted: (value) {
              widget.onSubmitted?.call(value);
              setState(() {
                filteredSuggestions.clear();
              });
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        widget.controller.clear();
                        _updateSuggestions('');
                        widget.onChanged?.call('');
                      },
                    )
                  : null,
            ).applyDefaults(context.themeData.inputDecorationTheme),
          ),
          if (filteredSuggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2)),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: filteredSuggestions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final suggestion = filteredSuggestions[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () => _selectSuggestion(suggestion),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
