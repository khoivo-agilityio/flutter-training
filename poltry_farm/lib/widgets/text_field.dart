import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';

class PfTextField extends StatefulWidget {
  const PfTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.validator,
    this.focusNode,
    this.semanticsLabel,
    this.inputDecoration,
    this.onChanged,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? semanticsLabel;
  final InputDecoration? inputDecoration;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;

  @override
  State<PfTextField> createState() => _PfTextFieldState();
}

class _PfTextFieldState extends State<PfTextField> {
  final _fieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticsLabel,
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          TextFormField(
            key: _fieldKey,
            focusNode: widget.focusNode,
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.label,
            ).applyDefaults(context.themeData.inputDecorationTheme),
            onTapOutside: (event) {
              widget.focusNode?.unfocus();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
