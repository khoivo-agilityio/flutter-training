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
    this.padding,
  });

  // The semantic label for accessibility (screen readers)
  final String semanticsLabel;

  // The widget displayed as the button's content (usually text or icon)
  final Widget child;

  // The width of the button
  final double? width;

  // The height of the button
  final double? height;

  // The background color of the button
  final Color? fillColor;

  // The text color of the button's child
  final Color? textColor;

  // The callback function to execute when the button is pressed
  final VoidCallback? onPressed;

  // The padding inside the button
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      button: true,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: fillColor ?? context.colorScheme.primary,
          foregroundColor: textColor ?? context.colorScheme.onPrimary,
          minimumSize: Size(width ?? double.infinity, height ?? 48),
          textStyle: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          padding: padding,
        ),
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
