import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfCard extends StatelessWidget {
  const PfCard({
    super.key,
    this.title,
    this.subTitle,
    this.description,
    this.image,
    this.trailingIcon,
    this.onTap,
    this.semanticLabel,
  });

  final String? title;
  final String? subTitle;
  final String? description;
  final Widget? image;
  final Widget? trailingIcon;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final effectiveLabel = semanticLabel ??
        [
          if (title != null) title,
          if (subTitle != null) subTitle,
        ].join(', ');

    return Semantics(
      container: true,
      label: effectiveLabel,
      button: true,
      enabled: onTap != null,
      hint: onTap != null ? 'Double tap to open' : null,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                if (image != null) ...[
                  ExcludeSemantics(
                    child: SizedBox(width: double.infinity, child: image!),
                  ),
                  const SizedBox(height: 2),
                ] else ...[
                  const Spacer()
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null ||
                            subTitle != null ||
                            description != null) ...[
                          PfText(
                            text: title ?? '',
                            variant: PfTextStyleVariant.bodyMedium,
                            fontWeight: FontWeight.w700,
                          ),
                          if (subTitle != null) ...[
                            const SizedBox(height: 4),
                            PfText(
                              text: subTitle!,
                              variant: PfTextStyleVariant.bodyMedium,
                              color: context.colorScheme.onSurface,
                            ),
                          ],
                          if (description != null) ...[
                            const SizedBox(height: 4),
                            PfText(
                              text: description!,
                              variant: PfTextStyleVariant.bodyMedium,
                              color: context.colorScheme.onSurface,
                            ),
                          ]
                        ],
                      ],
                    ),
                    if (trailingIcon != null) ...[
                      ExcludeSemantics(
                        child: trailingIcon!,
                      ),
                    ] else ...[
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
