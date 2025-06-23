/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const SvgGenImage cibApple = SvgGenImage('assets/cib_apple.svg');
  static const SvgGenImage facebookIc = SvgGenImage('assets/facebook_ic.svg');
  static const SvgGenImage googleIc = SvgGenImage('assets/google_ic.svg');
  static const SvgGenImage icBatches = SvgGenImage('assets/ic_batches.svg');
  static const SvgGenImage icBuySell = SvgGenImage('assets/ic_buy_sell.svg');
  static const SvgGenImage icFeedManagement = SvgGenImage(
    'assets/ic_feed_management.svg',
  );
  static const SvgGenImage icLogout = SvgGenImage('assets/ic_logout.svg');
  static const SvgGenImage icOptimization = SvgGenImage(
    'assets/ic_optimization.svg',
  );
  static const SvgGenImage icOutlineFileUpload = SvgGenImage(
    'assets/ic_outline-file-upload.svg',
  );
  static const SvgGenImage icPhone = SvgGenImage('assets/ic_phone.svg');
  static const SvgGenImage icSetting = SvgGenImage('assets/ic_setting.svg');
  static const SvgGenImage icStore = SvgGenImage('assets/ic_store.svg');
  static const SvgGenImage icSuccessMark = SvgGenImage(
    'assets/ic_success_mark.svg',
  );
  static const SvgGenImage icThreeDots = SvgGenImage(
    'assets/ic_three_dots.svg',
  );
  static const SvgGenImage icTrolley = SvgGenImage('assets/ic_trolley.svg');
  static const AssetGenImage image1 = AssetGenImage('assets/image 1.png');
  static const AssetGenImage imgChicken = AssetGenImage(
    'assets/img_chicken.png',
  );
  static const AssetGenImage imgChickenFarm = AssetGenImage(
    'assets/img_chicken_farm.png',
  );
  static const AssetGenImage imgChicks = AssetGenImage('assets/img_chicks.png');
  static const AssetGenImage imgDucks = AssetGenImage('assets/img_ducks.png');
  static const AssetGenImage imgEggs = AssetGenImage('assets/img_eggs.png');
  static const AssetGenImage imgHomePoster = AssetGenImage(
    'assets/img_home_poster.png',
  );
  static const SvgGenImage profile = SvgGenImage('assets/profile.svg');

  /// List of all assets
  static List<dynamic> get values => [
    aEnv,
    cibApple,
    facebookIc,
    googleIc,
    icBatches,
    icBuySell,
    icFeedManagement,
    icLogout,
    icOptimization,
    icOutlineFileUpload,
    icPhone,
    icSetting,
    icStore,
    icSuccessMark,
    icThreeDots,
    icTrolley,
    image1,
    imgChicken,
    imgChickenFarm,
    imgChicks,
    imgDucks,
    imgEggs,
    imgHomePoster,
    profile,
  ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
