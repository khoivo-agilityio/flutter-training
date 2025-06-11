import 'dart:io';
import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/widgets/assets.dart';

class PfAvatar extends StatelessWidget {
  const PfAvatar({
    super.key,
    required this.imgUrl,
    this.imageFile,
    this.size = 40.0,
    this.onTap,
  });

  final String imgUrl;
  final File? imageFile;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'User Avatar',
      child: GestureDetector(
        onTap: onTap,
        child: Stack(children: [
          SizedBox(
            height: size,
            width: size,
            child: CircleAvatar(
              backgroundColor: context.colorScheme.surface,
              child: ClipOval(
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        width: size,
                        height: size,
                        fit: BoxFit.cover,
                      )
                    : imgUrl.isNotEmpty
                        ? PfCachedNetworkImage(
                            width: size,
                            height: size,
                            url: imgUrl,
                            boxFit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: size,
                            color: context.colorScheme.onSurface,
                          ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.edit_rounded,
                color: context.colorScheme.onPrimary,
                size: 16,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
