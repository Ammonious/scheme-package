import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scheme_package/src/global_widgets/auto_size_text.dart';
import 'package:scheme_package/src/ui/styles.dart';
 import 'package:scheme_theme/scheme_theme.dart';
import 'button_constants.dart';

class GradientButton extends StatefulWidget {
	final Function onTap;
	final Function(Rect sourceRect) onTapRect;
	final String label;
	final double height;
	final double width;
	final TextStyle textStyle;
	final List<BoxShadow> boxShadow;
	final bool superEllipseShape;
	final IconData iconData;
	final Color color;
	final LinearGradient gradient;
	final double iconSize;
	final BorderRadius borderRadius;
	final Widget child;
	final bool enabled;
	  GradientButton(
			{ Key key, this.onTap, this.label = '', this.height = 50, this.width = 200, this.textStyle, this.boxShadow, this.superEllipseShape = false, this.color = Colors
					.white, this.iconData, this.iconSize = 24, this.borderRadius, this.gradient, this.child, this.enabled = true, this.onTapRect,})
			: super(key: key);

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
	@override
	Widget build(BuildContext context) {

		final RenderBox box = context.findRenderObject();
		final Rect sourceRect = box != null ? box.localToGlobal(Offset.zero) & box.size : Rect.zero;

		return AnimatedContainer(duration: normalDuration,
			height: widget.height,
			width: widget.width,
			decoration: widget.superEllipseShape ?
			superEllipseDecoration(widget.boxShadow, widget.gradient ?? schemeGradient(colorOne: widget.color,colorTwo: widget.color.shade900), widget.borderRadius) :
			regularThemeDecoration(widget.boxShadow, widget.gradient ?? schemeGradient(colorOne: widget.color,colorTwo: widget.color.shade900),
					widget.borderRadius ?? BorderRadius.circular(12)),
			child: Material(color: Colors.transparent,
				child: InkWell(splashColor: Colors.white.withOpacity(0.4),
					borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
					onTap: () => widget.onTapRect != null ? widget.onTapRect(sourceRect) : widget.onTap != null && widget.enabled ? widget.onTap() : () {},
					child: Container(
						padding: EdgeInsets.only(left: 8, right: 8), child: Center(child: widget.child == null ? defaultButton : widget.child),),),),);
	}

	get defaultButton =>
			Row(mainAxisAlignment: MainAxisAlignment.center,
				mainAxisSize: MainAxisSize.max,
				children: <Widget>[
					Visibility(visible: widget.iconData != null,
						child: Container(margin: EdgeInsets.only(right: 8),
							child: Icon(widget.iconData, size: widget.iconSize,
								color: widget.gradient != null ? widget.gradient.colors.last.textColor :
								widget.color.shade700.textColor,),),),
					AutoSizeText(widget.label,
						maxLines: 1,
						style: widget.textStyle == null ? schemeBtnFont.copyWith(color: widget.gradient != null ? widget.gradient.colors.last.textColor : widget.color.shade900.textColor) : widget.textStyle.copyWith(color: widget.gradient != null ? widget.gradient.colors.last.textColor : widget.color.shade900.textColor),),
				],);
}
