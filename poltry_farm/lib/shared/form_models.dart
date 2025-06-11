import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poltry_farm/widgets/forms/form_validators.dart';

class PfPlainTextFormFieldSubState extends Equatable {
  const PfPlainTextFormFieldSubState({
    required this.semanticsLabel,
    required this.label,
    required this.text,
    required this.focusNode,
    this.validators,
    this.placeholder = '',
    this.keyboardType = const TextInputType.numberWithOptions(
      decimal: true,
    ),
    this.textInputAction = TextInputAction.next,
    this.maxLine = 1,
    this.maxLength,
    this.initialValue,
    this.inputFormatters,
    this.enable = true,
    this.required = false,
    this.hasLabelPlaceholder = true,
    this.enableObscureText = false,
    this.obscureText = false,
    this.autovalidateMode,
    this.hintText,
  });

  final String semanticsLabel;
  final String label;
  final String text;
  final String placeholder;
  final String? initialValue;
  final FocusNode focusNode;
  final List<PfValidator>? validators;
  final int maxLine;
  final int? maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final bool required;
  final TextInputAction? textInputAction;
  final bool hasLabelPlaceholder;
  final bool enableObscureText;
  final bool? obscureText;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;

  PfPlainTextFormFieldSubState clear() {
    return copyWith(text: '');
  }

  PfPlainTextFormFieldSubState clearvalidators() {
    return copyWith(
      text: '',
      validators: const [],
    );
  }

  PfPlainTextFormFieldSubState setEnable({bool isEnabled = true}) {
    return copyWith(
      enable: isEnabled,
    );
  }

  PfPlainTextFormFieldSubState setValue(String value) {
    return copyWith(text: value);
  }

  @override
  List<Object?> get props => [
        semanticsLabel,
        label,
        text,
        placeholder,
        maxLine,
        maxLength,
        initialValue,
        inputFormatters,
        enable,
        enableObscureText,
        obscureText,
        hintText,
        validators,
        hasLabelPlaceholder,
        focusNode,
      ];

  PfPlainTextFormFieldSubState copyWith({
    String? semanticsLabel,
    String? label,
    String? text,
    String? placeholder,
    String? initialValue,
    FocusNode? focusNode,
    List<PfValidator>? validators,
    int? maxLine,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool? enable,
    bool? required,
    TextInputAction? textInputAction,
    bool? hasLabelPlaceholder,
    bool? enableObscureText,
    bool? obscureText,
    AutovalidateMode? autovalidateMode,
    String? hintText,
  }) {
    return PfPlainTextFormFieldSubState(
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      label: label ?? this.label,
      text: text ?? this.text,
      placeholder: placeholder ?? this.placeholder,
      initialValue: initialValue ?? this.initialValue,
      focusNode: focusNode ?? this.focusNode,
      validators: validators ?? this.validators,
      maxLine: maxLine ?? this.maxLine,
      keyboardType: keyboardType ?? this.keyboardType,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enable: enable ?? this.enable,
      required: required ?? this.required,
      textInputAction: textInputAction ?? this.textInputAction,
      hasLabelPlaceholder: hasLabelPlaceholder ?? this.hasLabelPlaceholder,
      enableObscureText: enableObscureText ?? this.enableObscureText,
      obscureText: obscureText ?? this.obscureText,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      hintText: hintText ?? this.hintText,
    );
  }
}

class PfSearchTextFormFieldSubState extends Equatable {
  const PfSearchTextFormFieldSubState({
    required this.semanticsLabel,
    this.label,
    required this.text,
    required this.focusNode,
    this.validators,
    this.placeholder = '',
    this.keyboardType = const TextInputType.numberWithOptions(
      decimal: true,
    ),
    this.textInputAction = TextInputAction.next,
    this.maxLine = 1,
    this.maxLength,
    this.initialValue,
    this.inputFormatters,
    this.enable = true,
    this.required = false,
    this.hasLabelPlaceholder = true,
    this.enableObscureText = false,
    this.obscureText = false,
    this.autovalidateMode,
    this.hintText,
    this.suggestions,
  });

  final String semanticsLabel;
  final String? label;
  final String text;
  final String placeholder;
  final String? initialValue;
  final FocusNode focusNode;
  final List<PfValidator>? validators;
  final int maxLine;
  final int? maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final bool required;
  final TextInputAction? textInputAction;
  final bool hasLabelPlaceholder;
  final bool enableObscureText;
  final bool? obscureText;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final List<String>? suggestions;

  PfSearchTextFormFieldSubState clear() {
    return copyWith(text: '');
  }

  PfSearchTextFormFieldSubState clearvalidators() {
    return copyWith(
      text: '',
      validators: const [],
    );
  }

  PfSearchTextFormFieldSubState setEnable({bool isEnabled = true}) {
    return copyWith(
      enable: isEnabled,
    );
  }

  PfSearchTextFormFieldSubState setValue(String value) {
    return copyWith(text: value);
  }

  @override
  List<Object?> get props => [
        semanticsLabel,
        label,
        text,
        placeholder,
        maxLine,
        maxLength,
        initialValue,
        inputFormatters,
        enable,
        enableObscureText,
        obscureText,
        hintText,
        validators,
        hasLabelPlaceholder,
        focusNode,
        suggestions,
      ];

  PfSearchTextFormFieldSubState copyWith({
    String? semanticsLabel,
    String? label,
    String? text,
    String? placeholder,
    String? initialValue,
    FocusNode? focusNode,
    List<PfValidator>? validators,
    int? maxLine,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool? enable,
    bool? required,
    TextInputAction? textInputAction,
    bool? hasLabelPlaceholder,
    bool? enableObscureText,
    bool? obscureText,
    AutovalidateMode? autovalidateMode,
    String? hintText,
    List<String>? suggestions,
  }) {
    return PfSearchTextFormFieldSubState(
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      label: label ?? this.label,
      text: text ?? this.text,
      placeholder: placeholder ?? this.placeholder,
      initialValue: initialValue ?? this.initialValue,
      focusNode: focusNode ?? this.focusNode,
      validators: validators ?? this.validators,
      maxLine: maxLine ?? this.maxLine,
      keyboardType: keyboardType ?? this.keyboardType,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enable: enable ?? this.enable,
      required: required ?? this.required,
      textInputAction: textInputAction ?? this.textInputAction,
      hasLabelPlaceholder: hasLabelPlaceholder ?? this.hasLabelPlaceholder,
      enableObscureText: enableObscureText ?? this.enableObscureText,
      obscureText: obscureText ?? this.obscureText,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      hintText: hintText ?? this.hintText,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}

class PfDropdownFormFieldSubState extends Equatable {
  const PfDropdownFormFieldSubState({
    required this.semanticsLabel,
    this.label,
    this.text,
    required this.focusNode,
    this.validators,
    this.placeholder = '',
    this.keyboardType = const TextInputType.numberWithOptions(
      decimal: true,
    ),
    this.textInputAction = TextInputAction.next,
    this.maxLine = 1,
    this.maxLength,
    this.initialValue,
    this.inputFormatters,
    this.enable = true,
    this.required = false,
    this.hasLabelPlaceholder = true,
    this.enableObscureText = false,
    this.obscureText = false,
    this.autovalidateMode,
    this.hintText,
    this.items,
  });

  final String semanticsLabel;
  final String? label;
  final String? text;
  final String? placeholder;
  final String? initialValue;
  final FocusNode focusNode;
  final List<PfValidator>? validators;
  final int maxLine;
  final int? maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final bool required;
  final TextInputAction? textInputAction;
  final bool hasLabelPlaceholder;
  final bool enableObscureText;
  final bool? obscureText;
  final AutovalidateMode? autovalidateMode;
  final String? hintText;
  final List<String>? items;

  @override
  List<Object?> get props => [
        semanticsLabel,
        label,
        text,
        placeholder,
        maxLine,
        maxLength,
        initialValue,
        inputFormatters,
        enable,
        enableObscureText,
        obscureText,
        hintText,
        validators,
        hasLabelPlaceholder,
        focusNode,
        items,
      ];

  PfDropdownFormFieldSubState copyWith({
    String? semanticsLabel,
    String? label,
    String? text,
    String? placeholder,
    String? initialValue,
    FocusNode? focusNode,
    List<PfValidator>? validators,
    int? maxLine,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool? enable,
    bool? required,
    TextInputAction? textInputAction,
    bool? hasLabelPlaceholder,
    bool? enableObscureText,
    bool? obscureText,
    AutovalidateMode? autovalidateMode,
    String? hintText,
    List<String>? items,
  }) {
    return PfDropdownFormFieldSubState(
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      label: label ?? this.label,
      text: text ?? this.text,
      placeholder: placeholder ?? this.placeholder,
      initialValue: initialValue ?? this.initialValue,
      focusNode: focusNode ?? this.focusNode,
      validators: validators ?? this.validators,
      maxLine: maxLine ?? this.maxLine,
      keyboardType: keyboardType ?? this.keyboardType,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      enable: enable ?? this.enable,
      required: required ?? this.required,
      textInputAction: textInputAction ?? this.textInputAction,
      hasLabelPlaceholder: hasLabelPlaceholder ?? this.hasLabelPlaceholder,
      enableObscureText: enableObscureText ?? this.enableObscureText,
      obscureText: obscureText ?? this.obscureText,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      hintText: hintText ?? this.hintText,
      items: items ?? this.items,
    );
  }
}
