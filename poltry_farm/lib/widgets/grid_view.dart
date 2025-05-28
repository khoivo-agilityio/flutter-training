import 'package:flutter/material.dart';

class PfGridView extends StatelessWidget {
  const PfGridView({
    super.key,
    this.crossAxisCount,
    this.itemCount,
    required this.item,
  });

  final int? crossAxisCount;
  final int? itemCount;
  final Widget item;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
