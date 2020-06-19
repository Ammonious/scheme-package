import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheme_package/src/textfields/keyboard_avoider.dart';
import 'package:scheme_theme/scheme_theme.dart';

import '../../scheme_package.dart';
import 'form_constants.dart';

class AddressForm extends HookWidget {
  final SchemeFieldStyle fieldStyle;
  final TextStyle textStyle;
  final bool showIcon;
  final Color textColor;
  final Color hintColor;
  final Color themeColor;
  final Color cardColor;
  final double spacing;
  final bool showPhoneField;
  final List<BoxShadow> boxShadow;
  final Function(String state) onSelectState;
  final Function(String name,String phone, String email, String address, String city, String zip) valueListener;
  final String selectedState;
  AddressForm(  {this.showPhoneField = false,
    Key key,
    this.fieldStyle = SchemeFieldStyle.outline,this.boxShadow,
    this.showIcon = false,
    this.textColor = nearlyBlack,
    this.hintColor = Colors.grey,
    this.themeColor = Colors.blue,
    this.cardColor = Colors.white,
    this.spacing = 16,
    this.onSelectState,
    this.textStyle,
    @required this.valueListener,
    this.selectedState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final addressController = useTextEditingController();
    final cityController = useTextEditingController();
    final zipController = useTextEditingController();
    final nameFocus = useFocusNode();
    final phoneFocus = useFocusNode();
    final emailFocus = useFocusNode();
    final addressFocus = useFocusNode();
    final lineTwoFocus = useFocusNode();
    final cityFocus = useFocusNode();
    final zipFocus = useFocusNode();
    final stateNotifier = useState();

    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          textField('Full Name', nameFocus, showPhoneField ? phoneFocus : emailFocus, Boxicons.bxUserCircle, nameController,
              TextInputType.text, TextCapitalization.words,
              nameController: nameController,
              emailController: emailController,
              addressController: addressController,
              cityController: cityController,
              zipController: zipController),
          SizedBox(
            height: spacing,
          ),
          Visibility(visible: showPhoneField,child: Column(children: <Widget>[
            textField('Phone', phoneFocus, emailFocus, Boxicons.bxEnvelope, emailController,
                TextInputType.emailAddress, TextCapitalization.none,
                nameController: nameController,
                emailController: emailController,
                textInputFormatter: phoneFormatter,
                phoneController: phoneController,
                addressController: addressController,
                cityController: cityController,
                zipController: zipController),
            SizedBox(
              height: spacing,
            ),
          ],),),

          textField('Email', emailFocus, addressFocus, Boxicons.bxEnvelope, emailController,
              TextInputType.emailAddress, TextCapitalization.none,
              nameController: nameController,
              emailController: emailController,
              addressController: addressController,
              cityController: cityController,
              zipController: zipController),
          SizedBox(
            height: spacing,
          ),
          textField('Address', addressFocus, cityFocus, Boxicons.bxHomeAlt, addressController,
              TextInputType.visiblePassword, TextCapitalization.none,
              nameController: nameController,
              emailController: emailController,
              addressController: addressController,
              cityController: cityController,
              zipController: zipController),
          SizedBox(
            height: spacing,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: textField('City', cityFocus, zipFocus, Boxicons.bxMap, cityController,
                    TextInputType.text, TextCapitalization.words,
                    nameController: nameController,
                    emailController: emailController,
                    addressController: addressController,
                    cityController: cityController,
                    zipController: zipController),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                width: 100,
                child: dropDown(stateNotifier),
              )
            ],
          ),
          SizedBox(
            height: spacing,
          ),
          textField('Zip', zipFocus, null, Boxicons.bxMapPin, zipController, TextInputType.number,
              TextCapitalization.none,
              nameController: nameController,
              emailController: emailController,
              addressController: addressController,
              cityController: cityController,
              zipController: zipController),
        ],
      ),
    );
  }

  listener({String name,String phone, String email, String address, String city, String zip}) =>
      valueListener(name,phone, email, address, city, zip);

  textField(
      String label,
      FocusNode focusNode,
      FocusNode nextFocus,
      IconData iconData,
      TextEditingController controller,
      TextInputType inputType,
      TextCapitalization textCapitalization,
      {TextEditingController nameController,
        TextEditingController phoneController,
      TextEditingController emailController,
      TextEditingController addressController,
      TextEditingController cityController,
      TextEditingController zipController,TextInputFormatter textInputFormatter}) {
    switch (fieldStyle) {
      case SchemeFieldStyle.card:
        // TODO: Handle this case.
        return CardTextField(
          label: label,
          textFocus: focusNode,
          nextFocus: nextFocus,
          iconData: iconData,
          controller: controller,
          textCapitalization: textCapitalization,
          inputFormatters: [textInputFormatter],
          boxShadow: boxShadow ?? wideShadow,
          showIcon: showIcon,
          brandColor: themeColor,
          textColor: textColor,
          hintColor: hintColor,
          inputType: inputType,
          backgroundColor: cardColor,
          onChange: (text) => listener(
              name: nameController.text,
              phone: phoneController.text,
              email: emailController.text,
              address: addressController.text,
              city: cityController.text,
              zip: zipController.text),
        );
      case SchemeFieldStyle.outline:
        // TODO: Handle this case.
        return CustomTextField(
          labelText: label,
          controller: controller,
          focusNode: focusNode,
          nextNode: nextFocus,
          textColor: textColor,
          hintColor: hintColor,
          borderColor: hintColor,
          textCapitalization: textCapitalization,
          inputFormatters: [textInputFormatter],
          iconData: iconData,
          showIcon: showIcon,
          textInputType: inputType,
          onChange: (text) => listener(
              name: nameController.text,
              phone: phoneController.text,
              email: emailController.text,
              address: addressController.text,
              city: cityController.text,
              zip: zipController.text),
        );
    }
  }

  dropDown(ValueNotifier stateNotifier) {
    switch (fieldStyle) {
      case SchemeFieldStyle.outline:
        // TODO: Handle this case.
        return CustomDropDown(
          dataSource: stateDropDown(),
          showIcon: false,
          hintColor: hintColor,
          activeColor: themeColor,
          hintText: selectedState ?? 'State',
          titleText: 'State',
          hintStyle: textStyle,
          onChanged: (state) {
            stateNotifier.value = state;
            onSelectState(state);
          },
        );
      case SchemeFieldStyle.card:
        // TODO: Handle this case.
        return CardDropDown(
          dataSource: stateDropDown(),
          showIcon: false,
          hintColor: hintColor,
          activeColor: themeColor,
          hintText: stateNotifier.value ?? 'State',
          titleText: 'State',
          hintStyle: textStyle,
          onChanged: (state) {
            stateNotifier.value = state;
            onSelectState(state);
          },
        );
    }
  }
}
