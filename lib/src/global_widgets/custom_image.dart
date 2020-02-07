import 'package:flutter/material.dart';
import 'package:scheme_package/src/utils/constants.dart';

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
	CustomImage({
		            Key key,
		            this.placeholder,
		            this.width,
		            this.height,
		            this.fit = BoxFit.scaleDown,
		            this.loadingBuilder,
		            this.errorBuilder, this.imageUrl, this.fadeDuration, this.colorBlendMode,
	            }) : super(key: key);

	@override
	Widget build(BuildContext context) {

		return ImageFade(
			placeholder: placeholder,
			image: NetworkImage(imageUrl),

			width: width,
			height: height,
			fadeDuration: fadeDuration ?? Duration(seconds: 1),
			fit: fit,
			loadingBuilder: loadingBuilder,
			errorBuilder: errorBuilder,
		);
	}
}