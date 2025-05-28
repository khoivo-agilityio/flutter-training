import 'package:flutter/material.dart';

class PfElevatedButton extends StatelessWidget {
  const PfElevatedButton({
    super.key,
    required this.semanticsLabel,
    required this.text,
    this.width,
    this.height,
    this.fillColor,
    this.textColor,
  });

  final String semanticsLabel;
  final String text;
  final double? width;
  final double? height;
  final Color? fillColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
