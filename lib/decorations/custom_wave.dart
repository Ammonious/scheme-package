
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:scheme_package/utils/color_tools.dart';

class CustomWaveBackground extends StatelessWidget {
	final Color accentColor;
	final LinearGradient gradient;
CustomWaveBackground({Key key, this.accentColor = Colors.blue, this.gradient,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent,child: Stack(children: <Widget>[
	    ClipPath(
		    clipper: WaveClipperTwo(),
		    child: Container(
			    height: MediaQuery.of(context).size.height * 0.45,
			    color: accentColor.shade700.withOpacity(0.25),
		    ),
	    ),
	    ClipPath(
		    clipper: WaveClipperOne(),
		    child: Container(
			    height: MediaQuery.of(context).size.height * 0.4,
			    decoration: BoxDecoration(gradient: gradient),
		    ),
	    ),
    ],),);
  }
}
