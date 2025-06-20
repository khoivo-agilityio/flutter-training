import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? automaticallyImplyLeading;

  const PfAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: context.colorScheme.onPrimary,
        foregroundColor: context.colorScheme.onSurfaceVariant,
        title: PfText(
          text: title,
          variant: PfTextStyleVariant.labelLarge,
          fontWeight: FontWeight.bold,
        ),
        actions: actions,
        leading: leading ??
            (automaticallyImplyLeading ?? true
                ? Semantics(
                    button: true,
                    label: 'Back',
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        semanticLabel: 'Navigate Back to Previous Screen',
                      ),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  )
                : null),
        automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        centerTitle: false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
