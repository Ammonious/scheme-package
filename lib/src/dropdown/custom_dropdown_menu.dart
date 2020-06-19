import 'package:flutter/material.dart';
import 'package:scheme_package/src/dropdown/card_dropdown_menu.dart';
import 'package:scheme_package/src/forms/form_constants.dart';
import 'package:scheme_theme/scheme_theme.dart';

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
  final bool alignDropdown;
  final Color cardColor;
  final List<BoxShadow> boxShadow;
  final SchemeFieldStyle fieldStyle;
  final bool isDense;
  final bool isExpanded;
  final double imageSize;
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
    this.alignDropdown = false,
    this.fieldStyle = SchemeFieldStyle.outline,
    this.cardColor = Colors.white,
    this.boxShadow, this.isDense = true, this.isExpanded = true, this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return dropDown();
  }

  dropDown() {
    switch (fieldStyle) {
      case SchemeFieldStyle.card:
        // TODO: Handle this case.
        return CardDropDown(
          titleText: '',
          enabled: enabled,
          hintText: hintText,
          required: required,
          errorText: errorText,
          imageUrl: imageUrl,
          imageSize: imageSize,
          alignDropdown: alignDropdown,
          value: value,
          dataSource: dataSource,
          isExpanded:isExpanded,
          isDense: isDense,
          hintStyle: hintStyle,
          onChanged: (value) => onChanged(value),
          hintColor: hintColor,
          selectedColor: selectedColor,
          borderRadius: borderRadius,
          borderWidth: borderWidth,
          iconData: iconData,
          iconColor: hintColor,
          showIcon: showIcon,
          activeColor: activeColor,
        );
      case SchemeFieldStyle.outline:
        // TODO: Handle this case.
        return baseDropDown;
    }
  }

  get baseDropDown => Theme(
        data: ThemeData(cardColor: menuBackgroundColor),
        child: DropDownFormField(
          titleText: fieldStyle == SchemeFieldStyle.outline ? titleText : '',
          enabled: enabled,
          hintText: hintText,
          required: required,
          errorText: errorText,
          isExpanded:isExpanded,
          imageSize: imageSize,
          isDense: isDense,
          noBorder: fieldStyle == SchemeFieldStyle.outline ? false : true,
          borderColor: fieldStyle == SchemeFieldStyle.outline ? borderColor : Colors.transparent,
          imageUrl: imageUrl,
          value: value,
          dataSource: dataSource,
          alignDropdown: alignDropdown,
          textField: 'display',
          valueField: 'value',
          hintStyle: hintStyle,
          onChanged: (value) => onChanged(value),
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
