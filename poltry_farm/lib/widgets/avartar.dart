import 'package:flutter/material.dart';
import 'package:poltry_farm/extensions/context_extension.dart';
import 'package:poltry_farm/widgets/assets.dart';

class PfAvatar extends StatelessWidget {
  const PfAvatar({
    super.key,
    required this.imgUrl,
    this.size = 40.0,
    this.onTap,
  });

  final String imgUrl;
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
                child: imgUrl == ''
                    ? Icon(
                        Icons.person,
                        size: size,
                      )
                    : PfCachedNetworkImage(
                        width: size,
                        height: size,
                        url: imgUrl,
                        boxFit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          // positioned edit icon at the bottom right corner
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
                ),
              )),
        ]),
      ),
    );
  }
}
