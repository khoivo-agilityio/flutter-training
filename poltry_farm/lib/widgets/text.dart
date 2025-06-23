import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';

class PfBaseText extends StatelessWidget {
  const PfBaseText({
    required this.text,
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: key,
      maxLines: maxLines,
      textAlign: textAlign,
      style: style,
    );
  }
}

class PfTextVariant extends StatelessWidget {
  const PfTextVariant({
    required this.text,
    required this.baseStyle,
    super.key,
    this.color,
    this.textAlign,
    this.fontWeight,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final TextStyle? baseStyle;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;

  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return PfBaseText(
      text: text,
      textAlign: textAlign,
      style: baseStyle?.copyWith(
        color: color,
        fontWeight: fontWeight,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
      maxLines: maxLines,
    );
  }
}

class PfText extends StatelessWidget {
  const PfText({
    super.key,
    required this.text,
    required this.variant,
    this.color,
    this.textAlign,
    this.fontWeight,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final PfTextStyleVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  TextStyle? _getBaseStyle(BuildContext context) {
    final theme = context.textTheme;
    switch (variant) {
      case PfTextStyleVariant.displayLarge:
        return theme.displayLarge;
      case PfTextStyleVariant.displayMedium:
        return theme.displayMedium;
      case PfTextStyleVariant.displaySmall:
        return theme.displaySmall;
      case PfTextStyleVariant.headlineLarge:
        return theme.headlineLarge;
      case PfTextStyleVariant.headlineMedium:
        return theme.headlineMedium;
      case PfTextStyleVariant.headlineSmall:
        return theme.headlineSmall;
      case PfTextStyleVariant.titleLarge:
        return theme.titleLarge;
      case PfTextStyleVariant.titleMedium:
        return theme.titleMedium;
      case PfTextStyleVariant.titleSmall:
        return theme.titleSmall;
      case PfTextStyleVariant.labelLarge:
        return theme.labelLarge;
      case PfTextStyleVariant.labelMedium:
        return theme.labelMedium;
      case PfTextStyleVariant.labelSmall:
        return theme.labelSmall;
      case PfTextStyleVariant.bodyLarge:
        return theme.bodyLarge;
      case PfTextStyleVariant.bodyMedium:
        return theme.bodyMedium;
      case PfTextStyleVariant.bodySmall:
        return theme.bodySmall;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PfTextVariant(
      text: text,
      baseStyle: _getBaseStyle(context),
      color: color,
      textAlign: textAlign,
      fontWeight: fontWeight,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

enum PfTextStyleVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  labelLarge,
  labelMedium,
  labelSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}
