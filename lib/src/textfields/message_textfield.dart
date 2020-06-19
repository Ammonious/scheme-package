import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_theme/scheme_theme.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController messageController;
  final FocusNode focusNode;
  final TextStyle textStyle;
  final Color themeColor;
  final String hintLabel;
  final double minHeight;
  final double maxHeight;
  MessageTextField(
      {Key key,
      this.messageController,
      this.focusNode,
      this.textStyle,
      this.themeColor,
      this.hintLabel,
      this.minHeight = 250,
      this.maxHeight = 250})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: normalDuration,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 25.50, color: Colors.black.withOpacity(0.13), offset: Offset.zero)
          ],
        ),
        child: GestureDetector(
          onTap: () => dismissKeyboardWithContext(context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(left: 16, right: 16),
              constraints: BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
              color: Colors.white,
              child: TextField(
                maxLines: null,
                controller: messageController,
                focusNode: focusNode,
                textInputAction: TextInputAction.newline,
                textCapitalization: TextCapitalization.sentences,
                style: textStyle,
                enableSuggestions: true,
                cursorColor: themeColor,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: hintLabel ?? "Enter your message..."),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
