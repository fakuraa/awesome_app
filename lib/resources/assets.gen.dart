/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  /// Directory path: lib/resources
  $LibResourcesGen get resources => const $LibResourcesGen();
}

class $LibResourcesGen {
  const $LibResourcesGen();

  /// Directory path: lib/resources/fonts
  $LibResourcesFontsGen get fonts => const $LibResourcesFontsGen();

  /// Directory path: lib/resources/images
  $LibResourcesImagesGen get images => const $LibResourcesImagesGen();
}

class $LibResourcesFontsGen {
  const $LibResourcesFontsGen();

  /// File path: lib/resources/fonts/RobotoCondensed-Black.ttf
  String get robotoCondensedBlack =>
      'lib/resources/fonts/RobotoCondensed-Black.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-BlackItalic.ttf
  String get robotoCondensedBlackItalic =>
      'lib/resources/fonts/RobotoCondensed-BlackItalic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-Bold.ttf
  String get robotoCondensedBold =>
      'lib/resources/fonts/RobotoCondensed-Bold.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-BoldItalic.ttf
  String get robotoCondensedBoldItalic =>
      'lib/resources/fonts/RobotoCondensed-BoldItalic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-ExtraBold.ttf
  String get robotoCondensedExtraBold =>
      'lib/resources/fonts/RobotoCondensed-ExtraBold.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-ExtraBoldItalic.ttf
  String get robotoCondensedExtraBoldItalic =>
      'lib/resources/fonts/RobotoCondensed-ExtraBoldItalic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-ExtraLight.ttf
  String get robotoCondensedExtraLight =>
      'lib/resources/fonts/RobotoCondensed-ExtraLight.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-ExtraLightItalic.ttf
  String get robotoCondensedExtraLightItalic =>
      'lib/resources/fonts/RobotoCondensed-ExtraLightItalic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-Italic.ttf
  String get robotoCondensedItalic =>
      'lib/resources/fonts/RobotoCondensed-Italic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-Light.ttf
  String get robotoCondensedLight =>
      'lib/resources/fonts/RobotoCondensed-Light.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-LightItalic.ttf
  String get robotoCondensedLightItalic =>
      'lib/resources/fonts/RobotoCondensed-LightItalic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-Medium.ttf
  String get robotoCondensedMedium =>
      'lib/resources/fonts/RobotoCondensed-Medium.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-MediumItalic.ttf
  String get robotoCondensedMediumItalic =>
      'lib/resources/fonts/RobotoCondensed-MediumItalic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-Regular.ttf
  String get robotoCondensedRegular =>
      'lib/resources/fonts/RobotoCondensed-Regular.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-SemiBold.ttf
  String get robotoCondensedSemiBold =>
      'lib/resources/fonts/RobotoCondensed-SemiBold.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-SemiBoldItalic.ttf
  String get robotoCondensedSemiBoldItalic =>
      'lib/resources/fonts/RobotoCondensed-SemiBoldItalic.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-Thin.ttf
  String get robotoCondensedThin =>
      'lib/resources/fonts/RobotoCondensed-Thin.ttf';

  /// File path: lib/resources/fonts/RobotoCondensed-ThinItalic.ttf
  String get robotoCondensedThinItalic =>
      'lib/resources/fonts/RobotoCondensed-ThinItalic.ttf';

  /// List of all assets
  List<String> get values => [
        robotoCondensedBlack,
        robotoCondensedBlackItalic,
        robotoCondensedBold,
        robotoCondensedBoldItalic,
        robotoCondensedExtraBold,
        robotoCondensedExtraBoldItalic,
        robotoCondensedExtraLight,
        robotoCondensedExtraLightItalic,
        robotoCondensedItalic,
        robotoCondensedLight,
        robotoCondensedLightItalic,
        robotoCondensedMedium,
        robotoCondensedMediumItalic,
        robotoCondensedRegular,
        robotoCondensedSemiBold,
        robotoCondensedSemiBoldItalic,
        robotoCondensedThin,
        robotoCondensedThinItalic
      ];
}

class $LibResourcesImagesGen {
  const $LibResourcesImagesGen();

  /// File path: lib/resources/images/bg_appbar.jpg
  AssetGenImage get bgAppbar =>
      const AssetGenImage('lib/resources/images/bg_appbar.jpg');

  /// File path: lib/resources/images/logo.png
  AssetGenImage get logo =>
      const AssetGenImage('lib/resources/images/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [bgAppbar, logo];
}

class Assets {
  Assets._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

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
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
