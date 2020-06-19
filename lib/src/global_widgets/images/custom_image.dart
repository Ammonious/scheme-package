import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';
import 'package:scheme_package/src/utils/custom_image_cache_manager.dart';

import 'image_fade.dart';

class CustomImage extends StatelessWidget {
  final Widget placeholder;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageLoadingBuilder loadingBuilder;
  final ImageFadeErrorBuilder errorBuilder;
  final String imageUrl;
  final String imagePath;
  final Duration fadeDuration;
  final BlendMode colorBlendMode;
  final bool useCacheNetworkImage;
  final Color loaderColor;
  final Color color;
  CustomImage({
    Key key,
    this.placeholder,
    this.width,
    this.height,
    this.fit = BoxFit.scaleDown,
    this.loadingBuilder,
    this.color,
    this.errorBuilder,
                this.imageUrl,
    this.fadeDuration,
    this.colorBlendMode,
    this.useCacheNetworkImage = true,
    this.loaderColor = Colors.blue, this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imagePath != null ? imageFade : useCacheNetworkImage ? cacheNetworkImage : imageFade;
  }

  get imageFade => ImageFade(
        placeholder: placeholder,
        image: imagePath != null ? AssetImage(imagePath) : NetworkImage(imageUrl),
        width: width,
        height: height,
        fadeDuration: fadeDuration ?? Duration(seconds: 1),
        fit: fit,
        color: color,
        loadingBuilder: loadingBuilder,
        colorBlendMode: colorBlendMode,
        errorBuilder: errorBuilder,
      );

  get cacheNetworkImage => CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: ImageCacheManager(),
        useOldImageOnUrlChange: true,
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width ?? 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.scaleDown,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
            child: SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(loaderColor),
                ))),
        errorWidget: (context, url, error) => Icon(
          Boxicons.bxErrorCircle,
          color: Colors.black,
        ),
      );
}
