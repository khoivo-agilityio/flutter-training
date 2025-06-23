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

  final String semanticsLabel;

  final String? title;

  final String? hintText;

  final String? errorMessage;

  final Widget? suffixIcon;

  final Widget? prefixIcon;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  final TextInputType? keyboardType;

  final FocusNode? focusNode;

  final VoidCallback? onTapOutside;

  final bool obscureText;

  final bool readOnly;

  final bool autofocus;

  final VoidCallback? onTap;

  final TextEditingController? controller;

  final bool hasValidation;

  final bool enabled;

  final String? initValue;

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
