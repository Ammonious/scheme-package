import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';

class FutureCustomImage extends StatelessWidget {
  final Future<String> imageUrlFuture;
  final Color themeColor;
  final Duration fadeDuration;
  final BlendMode colorBlendMode;
  final bool useCacheNetworkImage;
  final Widget placeholder;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageLoadingBuilder loadingBuilder;
  final ImageFadeErrorBuilder errorBuilder;
  FutureCustomImage(
      {Key key,
      @required this.imageUrlFuture,
      this.themeColor = Colors.blue,
      this.fadeDuration,
      this.colorBlendMode,
      this.useCacheNetworkImage = false,
      this.placeholder,
      this.width = 40,
      this.height = 40,
      this.fit,
      this.loadingBuilder,
      this.errorBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FutureBuilder(
          future: imageUrlFuture,
          builder: (context, snapshot) => futureBuilderShowLoading(snapshot.connectionState)
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(themeColor),
                  ),
                )
              : CustomImage(
                  imageUrl: snapshot.data,
                  colorBlendMode: colorBlendMode,
                  fadeDuration: fadeDuration,
                  placeholder: placeholder,
                  useCacheNetworkImage: false,
                  width: width,
                  height: height,
                  fit: fit,
                  loaderColor: themeColor,
                  loadingBuilder: loadingBuilder,
                  errorBuilder: errorBuilder,
                )),
    );
  }
}
