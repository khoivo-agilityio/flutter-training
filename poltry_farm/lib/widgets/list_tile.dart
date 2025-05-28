import 'package:flutter/material.dart';

class PfListTile extends StatelessWidget {
  const PfListTile({
    super.key,
    this.title,
    this.subTitle,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String? title;
  final String? subTitle;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
