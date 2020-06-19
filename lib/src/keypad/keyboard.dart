import 'dart:async';
import 'package:boxicons_flutter/boxicons_flutter.dart'; 
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/icons/constants/box_icons.dart';

import 'package:scheme_theme/scheme_theme.dart';
import 'keyboard_model.dart';
import 'package:scheme_theme/scheme_theme.dart';


/// The default keyboard height. Can we overriden by passing
///  `height` argument to `VirtualKeyboard` widget.
const double _virtualKeyboardDefaultHeight = 300;

const int _virtualKeyboardBackspaceEventPeriod = 250;

/// Virtual Keyboard widget.
class VirtualKeyboard extends StatefulWidget {
  /// Keyboard Type: Should be initiated at creation time.
  final VirtualKeyboardType type;

  /// Callback for [Key] press event. Called with pressed [Key] object.
  final Function onKeyPress;

  /// Virtual keyboard height. Default is 300
  final double keyboardHeight;

  /// Virtual keyboard height. Default is 300
  final double keyboardWidth;
 
 final TextStyle textStyle;

 final List<BoxShadow> boxShadow;
 

  /// The builder function will be called for each [Key] object.
  final Widget Function(BuildContext context, VirtualKey key) builder;

  /// Set to true if you want only to show Caps letters.
  final bool alwaysCaps;

  final Color backgroundColor;

  final Color themeColor;
 

  final double borderRadius;

  final bool showCompleter;

  VirtualKeyboard(
      {Key key,
      @required this.type,
      @required this.onKeyPress,
      this.builder,
      this.keyboardHeight = _virtualKeyboardDefaultHeight,
      this.alwaysCaps = false,
      this.backgroundColor = background,  this.keyboardWidth, this.borderRadius = 12, this.themeColor = Colors.pink
        , this.showCompleter = false, this.textStyle, this.boxShadow, })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VirtualKeyboardState();
  }
}

/// Holds the state for Virtual Keyboard class.
class _VirtualKeyboardState extends State<VirtualKeyboard> {
  VirtualKeyboardType type;
  Function onKeyPress;
  // The builder function will be called for each Key object.
  Widget Function(BuildContext context, VirtualKey key) builder;
  double height;
  bool alwaysCaps;
  /// [TextStyle] for keys.
  TextStyle get textStyle => widget.textStyle;
  Color get themeColor => widget.themeColor;
  // True if shift is enabled.
  bool isShiftEnabled = false;
  double width;
  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      type = widget.type;
      onKeyPress = widget.onKeyPress;
      height = widget.keyboardHeight;
      alwaysCaps = widget.alwaysCaps;

    });
  }

  @override
  void initState() {
    super.initState();
    width = widget.keyboardWidth ?? screenWidth;
    type = widget.type;
    onKeyPress = widget.onKeyPress;
    height = widget.keyboardHeight;
    alwaysCaps = widget.alwaysCaps;


  }

  @override
  Widget build(BuildContext context) {
    return type == VirtualKeyboardType.numeric ? _numeric() : _alphanumeric();
  }

  Widget _alphanumeric() {
    return Container(
      height: height,
      width:width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(widget.borderRadius),color: widget.backgroundColor,),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _rows(),
      ),
    );
  }

  Widget _numeric() {
    return Container(
      height: height,
      width:width,
      decoration: BoxDecoration(
        color: widget.backgroundColor,borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: widget.boxShadow ?? wideShadow,
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _rows(),
      ),
    );
  }

  /// Returns the rows for keyboard.
  List<Widget> _rows() {
    // Get the keyboard Rows
    List<List<VirtualKey>> keyboardRows =
        type == VirtualKeyboardType.numeric
            ? _getKeyboardRowsNumeric()
            : _getKeyboardRows();

    // Generate keyboard row.
    List<Widget> rows = List.generate(keyboardRows.length, (int rowNum) {
      return Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          // Generate keboard keys
          children: List.generate(
            keyboardRows[rowNum].length,
            (int keyNum) {
              // Get the VirtualKeyboardKey object.
              VirtualKey virtualKeyboardKey =
                  keyboardRows[rowNum][keyNum];

              Widget keyWidget;

              // Check if builder is specified.
              // Call builder function if specified or use default
              //  Key widgets if not.
              if (builder == null) {
                // Check the key type.
                switch (virtualKeyboardKey.keyType) {
                  case VirtualKeyType.string:
                    // Draw String key.
                    keyWidget = _keyboardDefaultKey(virtualKeyboardKey);
                    break;
                  case VirtualKeyType.action:
                    // Draw action key.
                    keyWidget = _keyboardDefaultActionKey(virtualKeyboardKey);
                    break;
                }
              } else {
                // Call the builder function, so the user can specify custom UI for keys.
                keyWidget = builder(context, virtualKeyboardKey);

                if (keyWidget == null) {
                  throw 'builder function must return Widget';
                }
              }

              return keyWidget;
            },
          ),
        ),
      );
    });

    return rows;
  }

  // True if long press is enabled.
  bool longPress;

  /// Creates default UI element for keyboard Key.
  Widget _keyboardDefaultKey(VirtualKey key) {
    return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(100)),
      onTap: () {
        onKeyPress(key);
      },
      child: Container(
        height: height / keyRows.length,
        child: Center(
            child: Text(
          alwaysCaps
              ? key.capsText
              : (isShiftEnabled ? key.capsText : key.text),
          style: textStyle,
        )),
      ),
    ));
  }

  /// Creates default UI element for keyboard Action Key.
  Widget _keyboardDefaultActionKey(VirtualKey key) {
    // Holds the action key widget.
    Widget actionKey;

    // Switch the action type to build action Key widget.
    switch (key.action) {
      case VirtualKeyboardKeyAction.backspace:
        actionKey = GestureDetector(
            onLongPress: () {
              longPress = true;
              // Start sending backspace key events while longPress is true
              Timer.periodic(
                  Duration(milliseconds: _virtualKeyboardBackspaceEventPeriod),
                  (timer) {
                if (longPress) {
                  onKeyPress(key);
                } else {
                  // Cancel timer.
                  timer.cancel();
                }
              });
            },
            onLongPressUp: () {
              // Cancel event loop
              longPress = false;
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Icon(Boxicons.bxTagX, color: themeColor, size: 28),
            ));
        break;
      case VirtualKeyboardKeyAction.shift:
        actionKey = Icon(Icons.arrow_upward, color: themeColor);
        break;
      case VirtualKeyboardKeyAction.space:
        actionKey = actionKey = Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(24)), width: screenWidth * 0.25, child: Center(child: Icon(Icons.space_bar, color: themeColor)));
        break;
      case VirtualKeyboardKeyAction.enter:
        actionKey = Container(padding: EdgeInsets.only(left: 12,right: 12,top: 4,bottom: 4), decoration: BoxDecoration(color: themeColor,borderRadius: BorderRadius.circular(8)),
          child: Icon(
            BoxIcon.bxCheck,
            color: themeColor.textColor,
          ),
        );
        break;
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          if (key.action == VirtualKeyboardKeyAction.shift) {
            if (!alwaysCaps) {
              setState(() {
                isShiftEnabled = !isShiftEnabled;
              });
            }
          }

          onKeyPress(key);
        },
        child: Container(
          alignment: Alignment.center,
          height: height / keyRows.length,
          child: actionKey,
        ),
      ),
    );
  }
}


/// Returns a list of `VirtualKeyboardKey` objects for Numeric keyboard.
List<VirtualKey> _getKeyboardRowKeysNumeric(rowNum) {
  // Generate VirtualKeyboardKey objects for each row.
  return List.generate(keyRowsNumeric[rowNum].length, (int keyNum) {
    // Get key string value.
    String key = keyRowsNumeric[rowNum][keyNum];

    // Create and return new VirtualKeyboardKey object.
    return VirtualKey(
      text: key,
      capsText: key.toUpperCase(),
      keyType: VirtualKeyType.string,
    );
  });
}

/// Returns a list of `VirtualKeyboardKey` objects.
List<VirtualKey> _getKeyboardRowKeys(rowNum) {
  // Generate VirtualKeyboardKey objects for each row.
  return List.generate(keyRows[rowNum].length, (int keyNum) {
    // Get key string value.
    String key = keyRows[rowNum][keyNum];

    // Create and return new VirtualKeyboardKey object.
    return VirtualKey(
      text: key,
      capsText: key.toUpperCase(),
      keyType: VirtualKeyType.string,
    );
  });
}

/// Returns a list of VirtualKeyboard rows with `VirtualKeyboardKey` objects.
List<List<VirtualKey>> _getKeyboardRows() {
  // Generate lists for each keyboard row.
  return List.generate(keyRows.length, (int rowNum) {
    // Will contain the keyboard row keys.
    List<VirtualKey> rowKeys = [];

    // We have to add Action keys to keyboard.
    switch (rowNum) {
      case 1:
        // String keys.
        rowKeys = _getKeyboardRowKeys(rowNum);


        break;
      case 2:
        // String keys.
        rowKeys = _getKeyboardRowKeys(rowNum);

        // 'Backspace' button.

        // 'Return' button.

        break;
      case 3:

        rowKeys.add(
          VirtualKey(
              keyType: VirtualKeyType.action,
              action: VirtualKeyboardKeyAction.backspace),
        );
        // String keys.
        rowKeys.addAll(_getKeyboardRowKeys(rowNum));
        rowKeys.add(
          VirtualKey(
              keyType: VirtualKeyType.action,
              action: VirtualKeyboardKeyAction.enter,
              text: '\n',
              capsText: '\n'),
        );

        break;
      case 4:
        // String keys.
        rowKeys = _getKeyboardRowKeys(rowNum);

        // Insert the space key into second position of row.
        rowKeys.insert(
          1,
          VirtualKey(
              keyType: VirtualKeyType.action,
              text: ' ',
              capsText: ' ',
              action: VirtualKeyboardKeyAction.space),
        );
        rowKeys.add(
          VirtualKey(
              keyType: VirtualKeyType.action,
              action: VirtualKeyboardKeyAction.enter,
              text: '\n',
              capsText: '\n'),
        );
        break;
      default:
        rowKeys = _getKeyboardRowKeys(rowNum);
    }

    return rowKeys;
  });
}

/// Returns a list of VirtualKeyboard rows with `VirtualKeyboardKey` objects.
List<List<VirtualKey>> _getKeyboardRowsNumeric() {
  // Generate lists for each keyboard row.
  return List.generate(keyRowsNumeric.length, (int rowNum) {
    // Will contain the keyboard row keys.
    List<VirtualKey> rowKeys = [];

    // We have to add Action keys to keyboard.
    switch (rowNum) {
      case 3:
        // String keys.
        rowKeys.add(
          VirtualKey(
              keyType: VirtualKeyType.action,
              action: VirtualKeyboardKeyAction.backspace),
        );
        rowKeys.addAll(_getKeyboardRowKeysNumeric(rowNum));
        rowKeys.add(
          VirtualKey(
              keyType: VirtualKeyType.action,
              action: VirtualKeyboardKeyAction.enter,
              text: '\n',
              capsText: '\n'),
        );
        // Right Shift

        break;
      default:
        rowKeys = _getKeyboardRowKeysNumeric(rowNum);
    }

    return rowKeys;
  });
}
