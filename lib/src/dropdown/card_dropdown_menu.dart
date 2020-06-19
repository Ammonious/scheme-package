import 'package:flutter/material.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'dropdown_formfield.dart';

class CardDropDown extends StatelessWidget {
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
  final Color iconColor;
  final bool showIcon;
  final Color activeColor;
  final Color menuBackgroundColor;
  final Color cardColor;
  final TextStyle hintStyle;
  final bool enabled;
  final String imageUrl;
  final List<BoxShadow> boxShadow;
  final bool alignDropdown;
  final bool isDense;
  final double imageSize;
  final bool isExpanded;
  CardDropDown({
    Key key,
    this.activeColor = Colors.blue,
    this.onChanged,
    this.iconData,
    this.iconColor = Colors.grey,
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
    this.enabled = true,
    this.cardColor = Colors.white,
    this.imageUrl, this.boxShadow, this.alignDropdown = false, this.isDense = true, this.isExpanded = true, this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: cardColor,
            boxShadow: boxShadow ?? wideShadow,
            borderRadius: BorderRadius.circular(8)),
        child: Theme(
          data: ThemeData(cardColor: menuBackgroundColor),
          child: DropDownFormField(
            titleText: '',
            enabled: enabled,
            hintText: hintText,
            required: required,
            errorText: errorText,
            imageUrl: imageUrl,
            imageSize: imageSize,
            noBorder: false,
            isExpanded:isExpanded,
            isDense: isDense,
            alignDropdown: alignDropdown,
            borderColor: Colors.transparent,
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
            iconColor: iconColor,
            showIcon: showIcon,
            activeColor: activeColor,
          ),
        ),
      ),
    );
  }
}
