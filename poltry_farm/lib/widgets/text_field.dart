import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/themes/typography.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfTextField extends StatefulWidget {
  const PfTextField({
    required this.semanticsLabel,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.hasValidation = true,
    this.enabled = true,
    this.errorMessage,
    this.title,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.focusNode,
    this.onTapOutside,
    this.onTap,
    this.controller,
    this.initValue,
    this.textInputAction,
    super.key,
  });

  // The semantic label for accessibility (screen readers)
  final String semanticsLabel;

  // The title text displayed above the text field
  final String? title;

  // The hint text shown inside the text field when it is empty
  final String? hintText;

  // The error message displayed below the text field
  final String? errorMessage;

  // An optional widget displayed at the end (right side) of the text field, such as an icon
  final Widget? suffixIcon;

  // An optional widget displayed at the start (left side) of the text field, such as an icon
  final Widget? prefixIcon;

  // Callback when the text in the field changes
  final ValueChanged<String>? onChanged;

  // Callback when the user submits the text (e.g., presses enter)
  final ValueChanged<String>? onSubmitted;

  // The type of keyboard to use for the text field
  final TextInputType? keyboardType;

  // The focus node for managing focus state of the text field
  final FocusNode? focusNode;

  // Callback when the user taps outside the text field
  final VoidCallback? onTapOutside;

  // Whether to obscure the text (e.g., for passwords)
  final bool obscureText;

  // Whether the text field is read-only
  final bool readOnly;

  // Whether the text field should autofocus when the widget is built
  final bool autofocus;

  // Callback when the text field is tapped
  final VoidCallback? onTap;

  // The controller for managing the text field's value
  final TextEditingController? controller;

  // Whether the text field should show validation feedback
  final bool hasValidation;

  // Whether the text field is enabled (can be interacted with)
  final bool enabled;

  // The initial value to display in the text field
  final String? initValue;

  // The action button to use for the keyboard (e.g., next, done)
  final TextInputAction? textInputAction;

  @override
  State<PfTextField> createState() => _PfTextFieldState();
}

class _PfTextFieldState extends State<PfTextField> {
  late final FocusNode? _focusNode;
  late final TextEditingController? _controller;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();

    if (widget.initValue != null && widget.controller == null) {
      _controller?.text = widget.initValue!;
    }
    _focusNode?.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onTapOutside?.call();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticsLabel,
      textField: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            PfText(
              text: widget.title!,
              variant: PfTextStyleVariant.labelLarge,
            ),
            const SizedBox(height: 8),
          ],
          TextField(
            focusNode: widget.focusNode,
            controller: _controller,
            obscureText: widget.obscureText,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            decoration: InputDecoration(
              fillColor: context.colorScheme.surface,
              hintText: widget.hintText,
              errorText: widget.errorMessage == null ? null : '',
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
            )..applyDefaults(context.themeData.inputDecorationTheme),
            style: TextStyle(
              fontFamily: PfTypography.familyBahnschrift,
              fontSize: PfTypography.fontSizeLabelLarge,
              fontWeight: FontWeight.w400,
              color: context.colorScheme.onSurfaceVariant,
            ),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            onTap: widget.onTap,
            textInputAction: widget.textInputAction,
          ),
          if (widget.hasValidation) ...[
            if (widget.errorMessage != null) ...[
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: PfText(
                      text: widget.errorMessage!,
                      color: context.colorScheme.error,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      variant: PfTextStyleVariant.bodyLarge,
                    ),
                  ),
                ],
              ),
            ] else
              const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
