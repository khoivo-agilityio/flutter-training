import 'package:flutter/material.dart';
import 'package:poltry_farm/widgets/text.dart';

class PfCard extends StatelessWidget {
  const PfCard({
    super.key,
    this.title,
    this.subTitle,
    this.image,
    this.trailingIcon,
    this.onTap,
    this.semanticLabel,
  });

  final String? title;
  final String? subTitle;
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
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null) ...[
                  ExcludeSemantics(
                    child: image!,
                  ),
                  const SizedBox(height: 8),
                ] else ...[
                  const Spacer()
                ],
                if (title != null || subTitle != null) ...[
                  PfText(
                    text: title ?? '',
                    variant: PfTextStyleVariant.bodyMedium,
                  ),
                  if (subTitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subTitle!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
                // if (image != null || trailingIcon != null)
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       if (image != null)
                //         Expanded(
                //           child: ExcludeSemantics(child: image!),
                //         )
                //       else
                //         const Spacer(),
                //       if (trailingIcon != null)
                //         ExcludeSemantics(child: trailingIcon!),
                //     ],
                //   ),
                // if (title != null) ...[
                //   const SizedBox(height: 8),
                //   Text(
                //     title!,
                //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
                //           fontWeight: FontWeight.w600,
                //         ),
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ],
                // if (subTitle != null) ...[
                //   const SizedBox(height: 4),
                //   Text(
                //     subTitle!,
                //     style: Theme.of(context).textTheme.bodySmall,
                //     maxLines: 2,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
