import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scheme_package/scheme_package.dart';

import 'constants/flare_icons.dart';
import 'flare_icon.dart';

enum SchemeIconType { icon, svg, image, flare, lottie, color }

class SchemeIcon extends StatelessWidget {
  final double size;
  final ColorScheme colorScheme;
  final String asset;
  final IconData icon;
  final String animation;
  final String flareFilePath;
  final SchemeIconType iconType;
  final FlareIconController flareIconController;

  const SchemeIcon._internal({
    Key key,
    this.size = 24,
    this.asset,
    this.icon,
    this.animation = 'idle',
    this.flareFilePath,
    this.iconType,
    this.flareIconController,
    this.colorScheme,
  }) : super(key: key);

  factory SchemeIcon.flare({
    double size = 24,
    ColorScheme colorScheme,
    Color color,
    @required String flareIcon,
    String animation = 'idle',
    String filePath,
    FlareIconController controller,
  }) {
    return SchemeIcon._internal(
        size: size,
        asset: flareIcon,
        flareIconController: controller,
        colorScheme: colorScheme ??
            Get.theme.colorScheme.copyWith(
                primary: color, primaryVariant: color, secondary: color, secondaryVariant: color),
        flareFilePath: filePath,
        iconType: SchemeIconType.flare,
        animation: animation);
  }

  factory SchemeIcon.icon({
    double size = 24,
    Color color = Colors.black,
    @required IconData iconData,
  }) {
    return SchemeIcon._internal(
      size: size,
      colorScheme: Get.theme.colorScheme.copyWith(
          primary: color, primaryVariant: color, secondary: color, secondaryVariant: color),
      icon: iconData,
      iconType: SchemeIconType.icon,
    );
  }

  factory SchemeIcon.image({
    double size = 24,
    Color color = Colors.black,
    @required String image,
  }) {
    return SchemeIcon._internal(
      size: size,
      colorScheme: Get.theme.colorScheme.copyWith(
          primary: color, primaryVariant: color, secondary: color, secondaryVariant: color),
      asset: image,
      iconType: SchemeIconType.image,
    );
  }

  factory SchemeIcon.svg({
    double size = 24,
    Color color = Colors.black,
    @required String svg,
  }) {
    return SchemeIcon._internal(
      size: size,
      colorScheme: Get.theme.colorScheme.copyWith(
          primary: color, primaryVariant: color, secondary: color, secondaryVariant: color),
      asset: svg,
      iconType: SchemeIconType.svg,
    );
  }

  factory SchemeIcon.lottie({
    double size = 24,
    Color color = Colors.black,
    @required String lottieIcon,
  }) {
    return SchemeIcon._internal(
      size: size,
      colorScheme: Get.theme.colorScheme.copyWith(
          primary: color, primaryVariant: color, secondary: color, secondaryVariant: color),
      asset: lottieIcon,
      iconType: SchemeIconType.lottie,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: initIconByType());
  }

  initIconByType() {
    switch (iconType) {
      case SchemeIconType.icon:
        return _icon;
      case SchemeIconType.svg:
        return _svgIcon;
      case SchemeIconType.image:
        if (asset.contains('http') || asset.contains('www')) return _urlIcon;
        return _imageIcon;
      case SchemeIconType.flare:
        return _flareIcon;
      case SchemeIconType.lottie:
        return _lottieIcon;
    }
  }

  get _icon => Icon(icon, size: size, color: colorScheme.primary);

  get _svgIcon => ColorFiltered(
    colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
    child: SvgPicture.asset(
      asset,
      color: colorScheme.primary,
      height: size,
      package: 'scheme_package',
      width: size,
      colorBlendMode: BlendMode.srcIn,
    ),
  );

  get _imageIcon => Image.asset(asset, color: colorScheme.primary, height: size, width: size);

  get _urlIcon => CachedNetworkImage(
    imageUrl: asset,
    useOldImageOnUrlChange: true,
    color: colorScheme.primary,
    height: size,
    width: size,
  );

  get _flareIcon => FlareIconMap(
    colorScheme: colorScheme,
    flareIcon: asset,
    iconSize: size,
    flrPath: flareFilePath,
    animation: animation,
    controller: flareIconController,
  );

  get _lottieIcon => _flareIcon; // LottieBuilder.asset(asset);

}
