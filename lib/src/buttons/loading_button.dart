import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class LoadingRoundButton extends HookWidget {
  final bool isLoading;
  final LinearGradient buttonGradient;
  final Function onTap;
  final List<BoxShadow> boxShadow;
  final EdgeInsets margin;
  final double size;

  LoadingRoundButton({
    Key key,
    this.isLoading = false,
    this.buttonGradient,
    this.boxShadow,
    this.onTap,
    this.margin,
    this.size = 52,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = useState<double>(size);
    final setMargin = margin ?? EdgeInsets.all(0);
    refreshButton(buttonWidth);
    return Material(
      color: Colors.transparent,
      child: Parent(
        style: ParentStyle()
          ..height(size)
          ..width(buttonWidth.value)
          ..margin(
              bottom: setMargin.bottom,
              top: setMargin.top,
              left: setMargin.left,
              right: setMargin.right)
          ..animate(350, Curves.fastOutSlowIn),
        child: AnimatedContainer(
          duration: normalDuration,
          decoration: mobileDecoration(isLoading),
          child: isLoading
              ? Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          height: 14,
                          width: 14,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Loading...',
                        style: GoogleFonts.raleway(
                            fontSize: 16,
                            color: buttonGradient.colors.last.textColor),
                      ),
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: InkWell(borderRadius: BorderRadius.circular(26),onTap: () =>  onPressed(buttonWidth),
                    child: IgnorePointer(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: buttonGradient.colors.last.textColor,
                        ),
                        onPressed: () =>(){},
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  refreshButton(ValueNotifier buttonWidth) =>
      isLoading ? buttonWidth.value = 130.00 : buttonWidth.value = size;

  onPressed(ValueNotifier buttonWidth) {
    buttonWidth.value = 130.00;
    Future.delayed(Duration(milliseconds: 350), () => onTap());
  }

  mobileDecoration(bool loading) => BoxDecoration(
      boxShadow: boxShadow ?? liftedShadow,
      gradient: buttonGradient,
      borderRadius: BorderRadius.circular(26));
}
