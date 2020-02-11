import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
	final String url;
	final double size;
	ProfileImage({Key key,@required this.url, this.size}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			height: size,
			width: size,
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(size / 2),
				boxShadow: <BoxShadow>[
					BoxShadow(
							color: Colors.grey.withOpacity(0.6),
							offset: Offset(2.0, 4.0),
							blurRadius: 8),
				],
			),
			child: CachedNetworkImage(
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
				placeholder: (context, url) =>
						Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(),)),
				errorWidget: (context, url, error) => Icon(
					Boxicons.bxErrorCircle,
					color: Colors.black,
				),
			),
		);
	}
}