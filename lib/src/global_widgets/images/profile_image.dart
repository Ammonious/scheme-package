import 'dart:io';

import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class ProfileImage extends StatelessWidget {
  final String url;
  final double size;
  final List<BoxShadow> boxShadow;
  final File imageFile;
  ProfileImage({Key key, @required this.url, this.imageFile, this.size, this.boxShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: boxShadow ?? liftedShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            child: imageFile != null ? fileImage : networkFade),
      ),
    );
  }

  get fileImage => Image.file(
        imageFile,
        height: size,
        width: size,
        fit: BoxFit.cover,
      );
  get networkFade => Container(height: size,width: size,decoration: BoxDecoration(borderRadius: BorderRadius.circular(size/2),boxShadow: boxShadow ?? normalShadow),
    child: Material(color: Colors.transparent,
      child: ClipRRect(
        child: ImageFade(
              placeholder: Container(
                height: size,
                width: size,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(size / 2), color: Colors.grey),
              ),
              image: NetworkImage(url),
              width: size,
              height: size,
              fadeDuration: Duration(seconds: 1),
              fit: BoxFit.cover,
            ),
      ),
    ),
  );
  get networkImage => CachedNetworkImage(
        imageUrl: url,
        useOldImageOnUrlChange: true,
        imageBuilder: (context, imageProvider) => Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Center(
            child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        )),
        errorWidget: (context, url, error) => Icon(
          Boxicons.bxErrorCircle,
          color: Colors.black,
        ),
      );
}
