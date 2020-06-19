import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'network_to_file_image/network_to_file_image.dart';
    get loadingUrl => 'https://firebasestorage.googleapis.com/v0/b/funrun-dd997.appspot.com/o/loading_placeholder.png?alt=media&token=7b2052c4-0b4f-452a-8a4f-ab0255f7cf0e';
class LocalCacheImage extends StatefulWidget {
  final String url;
  final double size;
  final Color brandColor;
  final String imageType;
  final BoxFit fit;
  final StreamingSharedPreferences preferences;
  LocalCacheImage({
    Key key,
    @required this.url,
    this.size = 24,
    this.brandColor = Colors.blue,
    this.imageType = 'logo',
    this.fit = BoxFit.scaleDown, this.preferences,
  }) : super(key: key);

  @override
  _LocalCacheImageState createState() => _LocalCacheImageState();
}

class _LocalCacheImageState extends State<LocalCacheImage> {
  @override
  void initState() {
    super.initState();
    saveFile(widget.imageType);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.preferences == null) return LoadingView();
    return PreferenceBuilder(
      preference: widget.preferences.getString('saved_date_${widget.imageType}', defaultValue: 'null'),
      builder: (context, filePath) => Image(
        image: NetworkToFileImage(file:filePath == 'null' ? null : File(filePath), url:filePath == 'null' && widget.url == null ? loadingUrl : widget.url, debug: true),
        height: widget.size,
        width: widget.size,
        fit: widget.fit,
      ),
    );
  }

  Future<File> saveFile(String filename) async {
    StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
    String date =
        prefs.getString('saved_date_${widget.imageType}', defaultValue: 'null').getValue();

    if (date != 'null') {
      Duration duration = DateTime.parse(date).difference(DateTime.now().add(Duration(days: 1)));
      if (duration.inSeconds >= 82800) {
        Directory dir = await getApplicationDocumentsDirectory();
        String pathName = p.join(dir.path, filename);
        File image = File(pathName);
        if (image != null) image.delete();
        prefs.setString('saved_date_${widget.imageType}',
            DateFormat(SORTABLE_DATE_TIME).format(DateTime.now()));

        File temp = await saveImage('url', widget.imageType);
        return temp;
      } else {
        Directory dir = await getApplicationDocumentsDirectory();
        String pathName = p.join(dir.path, filename);
        return File(pathName);
      }
    } else {
      prefs.setString(
          'saved_date_${widget.imageType}', DateFormat(SORTABLE_DATE_TIME).format(DateTime.now()));
      Directory dir = await getApplicationDocumentsDirectory();
      String pathName = p.join(dir.path, filename);
      return File(pathName);
    }
  }
}
