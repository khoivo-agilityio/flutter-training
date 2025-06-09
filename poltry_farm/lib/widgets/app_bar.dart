import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  const PfAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: context.colorScheme.onPrimary,
        foregroundColor: Colors.transparent,
        title: PfText(
          text: title,
          variant: PfTextStyleVariant.labelLarge,
          fontWeight: FontWeight.bold,
        ),
        actions: actions,
        leading: leading,
        centerTitle: false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
