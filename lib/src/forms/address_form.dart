import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../scheme_package.dart';
import 'form_constants.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final FocusNode nameFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode lineTwoFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FormFieldStyle fieldStyle;
  final TextStyle textStyle;
  final bool showIcon;
  final Color textColor;
  final Color hintColor;
  final Color themeColor;
  final Color cardColor;
  final double spacing;
  final Function(String state) onSelectState;
  final String selectedState;

  AddressForm(
      {Key key,
      this.nameController,
      this.addressController,
      this.cityController,
      this.fieldStyle = FormFieldStyle.Outline,
      this.showIcon = false,
      this.textColor = nearlyBlack,
      this.hintColor = Colors.grey,
      this.themeColor = Colors.blue,
      this.cardColor = Colors.white,
      this.spacing = 16,
      this.onSelectState,
      this.selectedState, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          textField('Full Name', nameFocus, addressFocus, Boxicons.bxUserCircle, nameController),
          SizedBox(
            height: spacing,
          ),
          textField('Address', addressFocus, null, Boxicons.bxHomeAlt, addressController),
          SizedBox(
            height: spacing,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: textField('City', cityFocus, null, Boxicons.bxMap, cityController),
              ),
              SizedBox(width: 16,),
              Container(width: 200,child: dropDown(),)
            ],
          )
        ],
      ),
    );
  }

  textField(
    String label,
    FocusNode focusNode,
    FocusNode nextFocus,
    IconData iconData,
    TextEditingController controller,
  ) {
    switch (fieldStyle) {
      case FormFieldStyle.Card:
        // TODO: Handle this case.
        return CardTextField(
          label: label,
          textFocus: focusNode,
          nextFocus: nextFocus,
          iconData: iconData,
          controller: controller,
          showIcon: showIcon,
          brandColor: themeColor,
          textColor: textColor,
          hintColor: hintColor,
          inputType: TextInputType.number,
          backgroundColor: cardColor,
        );
      case FormFieldStyle.Outline:
        // TODO: Handle this case.
        return CustomTextField(
          labelText: label,
          controller: controller,
          focusNode: focusNode,
          nextNode: nextFocus,
          textColor: textColor,
          hintColor: hintColor,
          iconData: iconData,
          showIcon: showIcon,
          textInputType: TextInputType.number,
        );
    }
  }

  dropDown() {
    switch (fieldStyle) {
      case FormFieldStyle.Outline:
        // TODO: Handle this case.
        return CustomDropDown(
          dataSource: stateDropDown(),
          showIcon: false,
          hintColor: hintColor,
          activeColor: themeColor,
          hintText:  selectedState ?? 'State',
          titleText: 'State',
          hintStyle: textStyle,
          onChanged: (state) => onSelectState(state),
        );
      case FormFieldStyle.Card:
        // TODO: Handle this case.
        return CardDropDown(dataSource: stateDropDown(),
          showIcon: false,
          hintColor: hintColor,
          activeColor: themeColor,
          hintText:  selectedState ?? 'State',
          titleText: 'State',
          hintStyle: textStyle,
          onChanged: (state) => onSelectState(state),);
    }
  }
}
