import 'package:flutter/material.dart';

class PfTextField extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            decoration: inputDecoration ??
                InputDecoration(
                  labelText: label,
                  hintText: hintText ?? label,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
          ),
        ],
      ),
    );
  }
}
