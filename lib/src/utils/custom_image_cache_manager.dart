import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageCacheManager extends BaseCacheManager{

	static const key = "customCache";

	static int ageInMinutes = 1380;

	static ImageCacheManager _instance;

	factory ImageCacheManager() {
		if (_instance == null) {
			_instance = new ImageCacheManager._();
		}
		return _instance;
	}

	ImageCacheManager._() : super(key,
		maxAgeCacheObject: Duration(minutes: ageInMinutes),
		maxNrOfCacheObjects: 50,);

	Future<String> getFilePath() async {
		var directory = await getTemporaryDirectory();
		return p.join(directory.path, key);
	}

	static Future<FileFetcherResponse> _customHttpGetter(String url, {Map<String, String> headers}) async {
		// Do things with headers, the url or whatever.
		Response response = await http.get(url, headers: headers);
		response.headers.update("cache-control", (val)=> "max-age=${ageInMinutes * 60}, public" );
		response.headers.update("expires", (val)=> HttpDate.format(DateTime.now().add(new Duration(minutes: ageInMinutes))).toString());
		return HttpFileFetcherResponse(response);
	}

}