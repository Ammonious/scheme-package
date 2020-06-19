import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/src/icons/constants/flare_icons.dart';
import '../../scheme_package.dart';

class FlareIconMap extends StatefulWidget {
  final String flareIcon;
  final double iconSize;
  final String flrPath;
  final String animation;
  final ColorScheme colorScheme;
  final FlareIconController controller;

  FlareIconMap({
    this.flrPath,
    this.animation = 'idle',
    this.flareIcon,
    this.iconSize,
    this.colorScheme,
                 this.controller,
  });

  @override
  _FlareIconMapState createState() => _FlareIconMapState();
}

class _FlareIconMapState extends State<FlareIconMap>  {

  FlareIconController get controller => widget.controller ?? FlareIconController(flareIcon:widget.flareIcon,defaultScheme: widget.colorScheme);
  FlutterActorShape primaryShape;
  FlutterActorShape primaryTwoShape;
  FlutterActorShape accentShape;
  FlutterActorShape accentTwoShape;
  List<FlutterColorFill> fills = List();
  String get flareIcon => widget.flareIcon;

  double get iconSize => widget.iconSize;


  @override
  Widget build(BuildContext context) {
    controller.isActive.value = true;
     return SizedBox(
       height: iconSize,
       width: iconSize,
       child: FlareActor(
         widget.flrPath != null ? '${widget.flrPath}' : flarePath,
         fit: BoxFit.contain,
         alignment: Alignment.center,
         callback: (animation) {
           setColorFills();
         },
         controller: controller,
         animation: widget.animation,
         isPaused: widget.animation == 'idle',
         artboard: flareIcon,
       ),
     );
  }



  setColorFills() {
    ColorScheme colorScheme = widget.colorScheme;

    Color primary = colorScheme.primary;
    Color primaryTwo = colorScheme.primaryVariant;
    Color accent = colorScheme.secondary;
    Color accentTwo = colorScheme.secondaryVariant;

    fills.forEach((fill) {
      if (fill.parent.name == 'primary') {
        if (primary.opacity < 1.0) fill.opacity = primary.opacity;
        fill.uiColor = primary;
      } else if (fill.parent.name == 'primary_2') {
        if (primaryTwo.opacity < 1.0) fill.opacity = primaryTwo.opacity;
        fill.uiColor = primaryTwo;
      } else if (fill.parent.name == 'accent') {
        if (accent.opacity < 1.0) fill.opacity = accent.opacity;
        fill.uiColor = accent;
      } else if (fill.parent.name == 'accent_2') {
        if (accentTwo.opacity < 1.0) fill.opacity = accentTwo.opacity;
        fill.uiColor = accentTwo;
      }
    });
  }


}

class FlareIconController extends FlareControls { 
  final String flareIcon;
  final ColorScheme defaultScheme;
  ColorScheme colorScheme;
  FlareIconController({this.flareIcon,this.defaultScheme});
  List<FlutterColorFill> fills = List();

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
     
    if (artboard != null && artboard.name == flareIcon) {
      artboard.nodes.forEach((actor) {
        if (actor != null && actor.children != null) {
          for (var node in actor.children) {
            if (node is FlutterActorShape) {
              FlutterColorFill fill = node?.fill as FlutterColorFill;
              fills.add(fill);
            }
          }
        }
      });
    }
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    setSelectedFills(colorScheme ?? defaultScheme);
    return false;
  }


  @override
  void setViewTransform(Mat2D viewTransform) {}

  setSelectedFills(colorScheme) {

    Color primary = colorScheme.primaryColor;
    Color primaryTwo = colorScheme.primaryAccent;
    Color accent = colorScheme.secondary;
    Color accentTwo = colorScheme.secondaryAccent;

    fills.forEach((fill) {
      if (fill.parent.name == 'primary') {
        if (primary.opacity < 1.0) fill.opacity = primary.opacity;
        fill.uiColor = primary;
      } else if (fill.parent.name == 'primary_2') {
        if (primaryTwo.opacity < 1.0) fill.opacity = primaryTwo.opacity;
        fill.uiColor = primaryTwo;
      } else if (fill.parent.name == 'accent') {
        if (accent.opacity < 1.0) fill.opacity = accent.opacity;
        fill.uiColor = accent;
      } else if (fill.parent.name == 'accent_2') {
        if (accentTwo.opacity < 1.0) fill.opacity = accentTwo.opacity;
        fill.uiColor = accentTwo;
      }
    });
  }


}
