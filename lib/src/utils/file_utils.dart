import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:scheme_package/scheme_package.dart';
import 'package:share_extend/share_extend.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'custom_image_cache_manager.dart';
import 'package:image/image.dart' as i;

Future<File> saveFile(String filename) async {
	Directory dir = await getApplicationDocumentsDirectory();
	String pathName = p.join(dir.path, filename);
	return File(pathName);
}

Future<File> getImageFromNetwork(String url) async {

	File file = await ImageCacheManager().getSingleFile(url);
	return file;
}

Future<File> saveImage(String url,String imageType) async {

	final file = await getImageFromNetwork(url);
	Directory dir = await getApplicationDocumentsDirectory();
	String pathName = p.join(dir.path, imageType);
	i.Image image = i.decodeImage(file.readAsBytesSync());

	StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
	await prefs.setString(imageType, '$pathName.png');

	// Save the thumbnail as a PNG.
	return File('$pathName.png')
		..writeAsBytesSync(i.encodePng(image));
}


Future<void> saveShareFile(String fileName,{String sheetTitle,String message}) async {
	 File file = await saveFile(fileName);

	return ShareExtend.share(file.path, "image");
}

Future<void> shareFile(File file,{String sheetTitle,String message}) async => ShareExtend.share(file.path, "image");


Future<dynamic> copyClipboard(String text) => Clipboard.setData(
ClipboardData(text: text));

Future<String> get _localPath async {
	final directory = await getApplicationDocumentsDirectory();

	return directory.path;
}