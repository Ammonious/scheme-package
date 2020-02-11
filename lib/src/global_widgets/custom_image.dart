import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/src/utils/constants.dart';
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
  final Duration fadeDuration;
  final BlendMode colorBlendMode;
  final bool useCacheNetworkImage;
  final Color loaderColor;
  CustomImage({
    Key key,
    this.placeholder,
    this.width,
    this.height,
    this.fit = BoxFit.scaleDown,
    this.loadingBuilder,
    this.errorBuilder,
    @required this.imageUrl,
    this.fadeDuration,
    this.colorBlendMode,
    this.useCacheNetworkImage = false,
    this.loaderColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useCacheNetworkImage ? cacheNetworkImage : imageFade;
  }

  get imageFade => ImageFade(
        placeholder: placeholder,
        image: NetworkImage(imageUrl),
        width: width,
        height: height,
        fadeDuration: fadeDuration ?? Duration(seconds: 1),
        fit: fit,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
      );

  get cacheNetworkImage => CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: ImageCacheManager(),
        useOldImageOnUrlChange: true,
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
            child: SizedBox(
                height: height * 0.35,
                width: width * 0.35,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(loaderColor),
                ))),
        errorWidget: (context, url, error) => Icon(
          Boxicons.bxErrorCircle,
          color: Colors.black,
        ),
      );
}
