import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class CustomWaveBackground extends StatefulWidget {
  final Color accentColor;
  final Color primaryColor;
  final LinearGradient gradient;
  final double height;
  final ScrollController scrollController;
  final bool enableAnimation;
  CustomWaveBackground({
    Key key,
    this.accentColor = Colors.blue,
    this.primaryColor,
    this.gradient, this.height = 300, this.scrollController, this.enableAnimation = true,
  }) : super(key: key);

  @override
  _CustomWaveBackgroundState createState() => _CustomWaveBackgroundState();
}

class _CustomWaveBackgroundState extends State<CustomWaveBackground> {
  ScrollController get scrollController => widget.scrollController ?? ScrollController();
  double height;
  double accentHeight;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    height = widget.height;
    accentHeight = widget.height + 85;
    double originalAccent = accentHeight + 85;

    if(widget.enableAnimation){
      scrollController.addListener(() {
        setState(() {
          height = calc(widget.height) > 0 ? calc(widget.height) : 0;
          accentHeight = calc(originalAccent) > 0 ? calc(originalAccent) : 0;
        });
      });
    }


  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: AnimatedContainer(duration: Duration(milliseconds: 500),
              height:accentHeight,
              color: widget.accentColor.shade700.withOpacity(0.25),
            ),
          ),
          ClipPath(
            clipper: WaveClipperOne(),
            child: AnimatedContainer(duration: Duration(milliseconds: 500),
              height: height,
              decoration: BoxDecoration(
                  gradient: widget.gradient ?? schemeGradient(color: widget.primaryColor ?? Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
  calc(double originalAmount){
   return originalAmount - (285 * (scrollController.offset / 100));
  }
}
