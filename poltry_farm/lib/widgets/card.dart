import 'package:flutter/material.dart';

class PfCard extends StatelessWidget {
  const PfCard({
    super.key,
    this.title,
    this.subTitle,
    this.image,
    this.trailingIcon,
  });

  final String? title;
  final String? subTitle;
  final Widget? image;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
