import 'package:flutter/material.dart';

import 'dropdown_formfield.dart';

class CustomDropDown extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final Function onChanged;
  final Color hintColor;
  final Color selectedColor;
  final BorderRadius borderRadius;
  final double borderWidth;
  final IconData iconData;
  final bool showIcon;
  final Color activeColor;
  final Color menuBackgroundColor;
  final TextStyle hintStyle;
  final bool noBorder;
  final bool enabled;
  final Color borderColor;
  final String imageUrl;
  CustomDropDown({
    Key key,
    this.activeColor = Colors.blue,
    this.onChanged,
    this.iconData,
    this.showIcon = false,
    this.titleText = 'Title',
    this.hintText = 'Select an option',
    this.required = false,
    this.errorText = 'Please select one option',
    this.value,
    this.dataSource,
    this.selectedColor = Colors.blue,
    this.hintColor = Colors.grey,
    this.borderWidth = 1,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.menuBackgroundColor = Colors.white,
    this.hintStyle,
    this.noBorder = false,
    this.enabled = true,
    this.borderColor = Colors.grey,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(cardColor: menuBackgroundColor),
      child: DropDownFormField(
        titleText: titleText,
        enabled: enabled,
        hintText: hintText,
        required: required,
        errorText: errorText,
        noBorder: noBorder,
        borderColor: borderColor,
        imageUrl: imageUrl,
        value: value,
        dataSource: dataSource,
        textField: 'display',
        valueField: 'value',
        hintStyle: hintStyle,
        onChanged: (value) {
          onChanged(value);
        },
        hintColor: hintColor,
        selectedColor: selectedColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
        iconData: iconData,
        iconColor: hintColor,
        showIcon: showIcon,
        activeColor: activeColor,
      ),
    );
  }
}
