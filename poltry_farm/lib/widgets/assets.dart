import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poltry_farm/resources/assets_generated/assets.gen.dart';

///
/// An enum defines all supported types of image loader
///
/// * [ImageLoaderType.assetPNG] load PNG image from asset
/// * [ImageLoaderType.assetSVG] load SVG image from asset
/// * [ImageLoaderType.cachedNetwork] return cache image if exists,
/// *   otherwises return network image
///
enum ImageLoaderType { assetPNG, assetSVG, cachedNetwork }

/// A widget that displays an image from a specified asset path.
///
/// This widget supports different types of image loaders defined by the
/// [ImageLoaderType] enum. By default, it assumes the image type is a PNG
/// asset. An assertion ensures that the image path does not start with 'http'
/// or 'https', as this widget is meant for local asset images only.
class PfAssetImage extends StatelessWidget {
  PfAssetImage({
    required this.semanticLabel,
    required this.path,
    super.key,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.boxFit,
    this.type = ImageLoaderType.assetPNG,
  }) : assert(
          !path.startsWith('http'),
          'Asset Image path should not start with http or https',
        );

  final String path;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final ImageLoaderType type;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return _PfImageLoader(
      semanticLabel: semanticLabel,
      url: path,
      type: type,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      color: color,
      boxFit: boxFit,
    );
  }
}

/// A widget that displays an image from a network source with caching support.
///
/// This widget uses the [_PfImageLoader] to display images from a cached
/// network source. It requires a [url] for the image source and optionally
/// accepts a [width], [height], [boxFit], and a custom [errorBuilder].
///
/// The default [width] and [height] are set to 40, and the default [boxFit]
/// is set to [BoxFit.contain].
class PfCachedNetworkImage extends StatelessWidget {
  const PfCachedNetworkImage({
    required this.semanticLabel,
    required this.url,
    this.width = 40,
    this.height = 40,
    this.boxFit = BoxFit.contain,
    this.errorBuilder,
    super.key,
  });

  final String semanticLabel;
  final String url;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return _PfImageLoader(
      semanticLabel: semanticLabel,
      url: url,
      type: ImageLoaderType.cachedNetwork,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      boxFit: boxFit,
    );
  }
}

/// A widget that loads and displays images from various sources with optional caching and error handling.
///
/// This widget supports loading images from asset images (PNG and SVG) and cached network images. It can optionally display
/// a custom error widget if the image fails to load and supports custom sizing, color, and fitting options.
class _PfImageLoader extends StatelessWidget {
  const _PfImageLoader({
    required this.semanticLabel,
    required this.type,
    required this.url,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.boxFit = BoxFit.cover,
  });

  final String semanticLabel;
  final ImageLoaderType type;
  final String url;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ImageLoaderType.assetPNG:
        return Image.asset(
          semanticLabel: semanticLabel,
          url,
          fit: boxFit,
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stackTrace,
          ) {
            log('Image $url load failed. Error: $error');
            return errorBuilder ?? Icon(Icons.broken_image, size: width);
          },
          width: width,
          height: height,
          color: color,
        );
      case ImageLoaderType.assetSVG:
        return SvgPicture.asset(
          semanticsLabel: semanticLabel,
          url,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          fit: boxFit ?? BoxFit.contain,
          placeholderBuilder: (BuildContext context) {
            return errorBuilder ?? Icon(Icons.broken_image, size: width);
          },
          width: width,
          height: height,
        );
      case ImageLoaderType.cachedNetwork:
        return Semantics(
          image: true,
          label: semanticLabel,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: boxFit,
            width: width,
            height: height,
            errorWidget: (BuildContext context, String url, dynamic error) {
              log('Image $url load failed. Error: $error');
              return errorBuilder ?? Icon(Icons.broken_image, size: width);
            },
            imageBuilder:
                (BuildContext context, ImageProvider<Object> provider) =>
                    Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: provider),
              ),
            ),
          ),
        );
    }
  }
}

class PfAssets {
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      cibApple = _PfCibAppleImage.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      facebookIc = _PfFacebookIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      googleIc = _PfGoogleIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icBatches = _PfBatchesIc.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icFeedManagement = _PfFeedManagementIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icLogout = _PfLogoutIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icOutlineFileUpload = _PfOutlineFileUploadIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icPhone = _PfPhoneIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icSetting = _PfSettingIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icStore = _PfStoreIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icSuccessMark = _PfSuccessMarkIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icThreeDots = _PfThreeDotsIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      icProfile = _PfProfileIcon.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      imgChickenFarm = _PfChickenFarmImage.new;
  static Widget Function({double? width, double? height, BoxFit? boxfit})
      imgHomePoster = _PfHomePosterImage.new;
}

class _PfCibAppleImage extends StatelessWidget {
  const _PfCibAppleImage({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.cibApple.keyName,
      boxFit: boxfit,
      path: Assets.cibApple.path,
      width: width ?? 27.35,
      height: height ?? 27.35,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfFacebookIcon extends StatelessWidget {
  const _PfFacebookIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.facebookIc.keyName,
      boxFit: boxfit,
      path: Assets.facebookIc.path,
      width: width ?? 27.35,
      height: height ?? 27.35,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfGoogleIcon extends StatelessWidget {
  const _PfGoogleIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.googleIc.keyName,
      boxFit: boxfit,
      path: Assets.googleIc.path,
      width: width ?? 27.35,
      height: height ?? 27.35,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfBatchesIc extends StatelessWidget {
  const _PfBatchesIc({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icBatches.keyName,
      boxFit: boxfit,
      path: Assets.icBatches.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfFeedManagementIcon extends StatelessWidget {
  const _PfFeedManagementIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icFeedManagement.keyName,
      boxFit: boxfit,
      path: Assets.icFeedManagement.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfLogoutIcon extends StatelessWidget {
  const _PfLogoutIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icLogout.keyName,
      boxFit: boxfit,
      path: Assets.icLogout.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfOutlineFileUploadIcon extends StatelessWidget {
  const _PfOutlineFileUploadIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icOutlineFileUpload.keyName,
      boxFit: boxfit,
      path: Assets.icOutlineFileUpload.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfPhoneIcon extends StatelessWidget {
  const _PfPhoneIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icPhone.keyName,
      boxFit: boxfit,
      path: Assets.icPhone.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfSettingIcon extends StatelessWidget {
  const _PfSettingIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icSetting.keyName,
      boxFit: boxfit,
      path: Assets.icSetting.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfStoreIcon extends StatelessWidget {
  const _PfStoreIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icStore.keyName,
      boxFit: boxfit,
      path: Assets.icStore.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfSuccessMarkIcon extends StatelessWidget {
  const _PfSuccessMarkIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icSuccessMark.keyName,
      boxFit: boxfit,
      path: Assets.icSuccessMark.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfThreeDotsIcon extends StatelessWidget {
  const _PfThreeDotsIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.icThreeDots.keyName,
      boxFit: boxfit,
      path: Assets.icThreeDots.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfProfileIcon extends StatelessWidget {
  const _PfProfileIcon({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.profile.keyName,
      boxFit: boxfit,
      path: Assets.profile.path,
      width: width ?? 44,
      height: height ?? 44,
      type: ImageLoaderType.assetSVG,
    );
  }
}

class _PfChickenFarmImage extends StatelessWidget {
  const _PfChickenFarmImage({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.imgChickenFarm.keyName,
      boxFit: boxfit,
      path: Assets.imgChickenFarm.path,
      width: width ?? 57,
      height: height ?? 53,
    );
  }
}

class _PfHomePosterImage extends StatelessWidget {
  const _PfHomePosterImage({this.width, this.height, this.boxfit});
  final double? height;
  final double? width;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
    return PfAssetImage(
      semanticLabel: Assets.imgHomePoster.keyName,
      boxFit: boxfit,
      path: Assets.imgHomePoster.path,
      width: width,
      height: height,
    );
  }
}
