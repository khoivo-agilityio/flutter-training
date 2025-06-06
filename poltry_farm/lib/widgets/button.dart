import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';

class PfElevatedButton extends StatelessWidget {
  const PfElevatedButton({
    super.key,
    required this.semanticsLabel,
    required this.child,
    this.width,
    this.height,
    this.fillColor,
    this.textColor,
    this.onPressed,
  });

  final String semanticsLabel;
  final Widget child;
  final double? width;
  final double? height;
  final Color? fillColor;
  final Color? textColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      button: true,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: fillColor ?? context.colorScheme.primary,
            foregroundColor: textColor ?? context.colorScheme.onPrimary,
            minimumSize: Size(width ?? double.infinity, height ?? 48),
            textStyle: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            )),
        child: child,
      ),
    );
  }
}

class PfIconButton extends StatelessWidget {
  const PfIconButton({
    super.key,
    required this.semanticsLabel,
    this.icon,
    this.fillColor,
    this.iconColor,
  });

  final String semanticsLabel;
  final Widget? icon;
  final Color? fillColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
