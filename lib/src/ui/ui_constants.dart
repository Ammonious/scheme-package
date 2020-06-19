

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

GlobalKey uiKey = new GlobalKey();
Future<Uint8List> capturePng({Function(Uint8List imageInMemory) onComplete}) async {
	try {
		print('inside');

		RenderRepaintBoundary boundary =
		uiKey.currentContext.findRenderObject();
		ui.Image image = await boundary.toImage(pixelRatio: 3.0);
		ByteData byteData =
		await image.toByteData(format: ui.ImageByteFormat.png);
		Uint8List pngBytes = byteData.buffer.asUint8List();
//      String bs64 = base64Encode(pngBytes);
//      print(pngBytes);
//      print(bs64);
		print('png done');

		onComplete(pngBytes);
		return pngBytes;
	} catch (e) {
		print(e);
		return null;
	}
}