import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class StreamingPrefsController extends StatelessWidget {
  final Widget child;
  StreamingPrefsController({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FutureProvider(
        create: (_) => StreamingSharedPreferences.instance,
        child: child,
      ),
    );
  }
}
