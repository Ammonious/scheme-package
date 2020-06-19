import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/textfields/keyboard_avoider.dart';
import 'package:scheme_package/src/textfields/message_textfield.dart';
import 'package:scheme_theme/scheme_theme.dart' hide SchemeTextField;

class EmailForm extends HookWidget {
  final SchemeFieldStyle fieldStyle;
  final Color textColor;
  final Color themeColor;
  final TextStyle textStyle;
  final double minHeight;
  final double maxHeight;
  final bool showSubmit;
  final Function(String subject,String message) onSubmit;
  EmailForm( {
    Key key,
    this.fieldStyle = SchemeFieldStyle.card,
    this.textColor = nearlyBlack,
    this.themeColor = Colors.blueAccent,
    this.textStyle,
    this.minHeight = 250,
    this.maxHeight = 250,
    this.showSubmit = false,
	             this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjectController = useTextEditingController();
    final messageController = useTextEditingController();
    final subjectFocus = useFocusNode();
    final messageFocus = useFocusNode();

    return Material(
      color: Colors.transparent,
      child: KeyboardAvoider(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          SchemeTextField(
            controller: subjectController,
            focusNode: subjectFocus,
            nextFocus: messageFocus,
            iconData: Boxicons.bxEnvelope,
            fieldStyle: fieldStyle,
            label: 'Subject',
            inputType: TextInputType.text,
            inputAction: TextInputAction.next,
            hintColor: textColor,
            textColor: textColor,
            themeColor: themeColor,
          ),
          SizedBox(
            height: 48,
          ),
          MessageTextField(
            messageController: messageController,
            focusNode: messageFocus,
            textStyle: textStyle,
            themeColor: themeColor,
            hintLabel: 'Enter Email Body...',
          ),
          Visibility(
            visible: showSubmit,
            child: GradientButton(
              label: 'Send',
              width: 100,
              superEllipseShape: true,
              textStyle: textStyle.copyWith(fontSize: 15, color: themeColor.textColor),
              color: themeColor,
	            onTap: () => onSubmit(subjectController.text,messageController.text),
            ),
          )
        ],
      ))),
    );
  }
}
