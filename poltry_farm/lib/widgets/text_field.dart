import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poltry_farm/extensions/context_extension.dart';

class PfTextField extends StatefulWidget {
  const PfTextField({
    required this.semanticsLabel,
    this.controller,
    this.label,
    this.placeholder,
    this.focusNode,
    this.onChanged,
    this.initialValue,
    this.onReset,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.inputDecoration,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onSubmitted,
    this.validator,
    this.autovalidateMode,
    this.enable,
    this.textCapitalization,
    this.onTap,
    this.readOnly,
    this.required = false,
    this.hasLabelPlaceholder = true,
    this.borderStyle,
    this.obscureText,
    this.textColor,
    super.key,
  });

  final String semanticsLabel;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? label;
  final String? placeholder;
  final FocusNode? focusNode;
  final ValueChanged<String?>? onChanged;
  final String? initialValue;
  final VoidCallback? onReset;
  final ValueChanged<String?>? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? inputDecoration;
  final String? Function(String?)? validator;
  final bool? enable;
  final TextCapitalization? textCapitalization;
  final bool? readOnly;
  final VoidCallback? onTap;
  final bool? required;
  final bool hasLabelPlaceholder;
  final InputBorder? borderStyle;
  final bool? obscureText;
  final Color? textColor;

  @override
  State<PfTextField> createState() => _PfTextFieldState();
}

class _PfTextFieldState extends State<PfTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticsLabel,
      textField: true,
      obscured: widget.obscureText ?? false,
      readOnly: widget.readOnly ?? false,
      focusable: widget.focusNode != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.hasLabelPlaceholder) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.label,
                    style: context.textTheme.labelLarge,
                  ),
                  if (widget.required ??
                      false) // Show the asterisk conditionally
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: context.colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ] else ...[
            const SizedBox(
              height: 8,
            ),
          ],
          TextField(
            readOnly: widget.readOnly ?? false,
            enabled: widget.enable ?? true,
            inputFormatters: widget.inputFormatters,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            style: context.textTheme.labelLarge?.copyWith(
              color: widget.textColor,
            ),
            controller: widget.controller,
            maxLength: widget.maxLength,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            decoration: widget.inputDecoration ??
                InputDecoration(
                  enabledBorder: widget.borderStyle,
                  border: widget.borderStyle,
                  errorBorder: widget.borderStyle,
                  focusedBorder: widget.borderStyle,
                  label: Text(widget.placeholder ?? ''),
                ),
            onSubmitted: widget.onSubmitted,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onTapOutside: (event) {
              widget.focusNode?.unfocus();
            },
            onTap: widget.onTap,
            obscureText: widget.obscureText ?? false,
            obscuringCharacter: '*',
          ),
        ],
      ),
    );
  }
}
