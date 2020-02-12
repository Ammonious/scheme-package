import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../scheme_package.dart';
import 'form_constants.dart';

class AddressForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController zipController;
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
      this.selectedState,
      this.textStyle,
      this.zipController})
      : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  FocusNode nameFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode lineTwoFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode zipFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          textField('Full Name', nameFocus, addressFocus, Boxicons.bxUserCircle,
              widget.nameController, TextInputType.text),
          SizedBox(
            height: widget.spacing,
          ),
          textField('Address', addressFocus, cityFocus, Boxicons.bxHomeAlt,
              widget.addressController, TextInputType.visiblePassword),
          SizedBox(
            height: widget.spacing,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: textField('City', cityFocus, zipFocus, Boxicons.bxMap, widget.cityController,
                    TextInputType.text),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                width: 100,
                child: dropDown(),
              )
            ],
          ),
          SizedBox(
            height: widget.spacing,
          ),
          textField(
              'Zip', zipFocus, null, Boxicons.bxMapPin, widget.zipController, TextInputType.number),
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
    TextInputType inputType,
  ) {
    switch (widget.fieldStyle) {
      case FormFieldStyle.Card:
        // TODO: Handle this case.
        return CardTextField(
          label: label,
          textFocus: focusNode,
          nextFocus: nextFocus,
          iconData: iconData,
          controller: controller,
          showIcon: widget.showIcon,
          brandColor: widget.themeColor,
          textColor: widget.textColor,
          hintColor: widget.hintColor,
          inputType: inputType,
          backgroundColor: widget.cardColor,
        );
      case FormFieldStyle.Outline:
        // TODO: Handle this case.
        return CustomTextField(
          labelText: label,
          controller: controller,
          focusNode: focusNode,
          nextNode: nextFocus,
          textColor: widget.textColor,
          hintColor: widget.hintColor,
          iconData: iconData,
          showIcon: widget.showIcon,
          textInputType: inputType,
        );
    }
  }

  dropDown() {
    switch (widget.fieldStyle) {
      case FormFieldStyle.Outline:
        // TODO: Handle this case.
        return CustomDropDown(
          dataSource: stateDropDown(),
          showIcon: false,
          hintColor: widget.hintColor,
          activeColor: widget.themeColor,
          hintText: widget.selectedState ?? 'State',
          titleText: 'State',
          hintStyle: widget.textStyle,
          onChanged: (state) => widget.onSelectState(state),
        );
      case FormFieldStyle.Card:
        // TODO: Handle this case.
        return CardDropDown(
          dataSource: stateDropDown(),
          showIcon: false,
          hintColor: widget.hintColor,
          activeColor: widget.themeColor,
          hintText: widget.selectedState ?? 'State',
          titleText: 'State',
          hintStyle: widget.textStyle,
          onChanged: (state) => widget.onSelectState(state),
        );
    }
  }
}
