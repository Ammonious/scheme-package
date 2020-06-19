import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/forms/form_constants.dart';
import 'package:scheme_package/src/textfields/card_textfield.dart';
import 'package:scheme_package/src/textfields/custom_text_field.dart';
import 'package:scheme_package/src/textfields/keyboard_avoider.dart';
import 'package:scheme_theme/scheme_theme.dart';

class PaymentForm extends HookWidget {
  final SchemeFieldStyle fieldStyle;
  final TextStyle textStyle;
  final bool showIcon;
  final Color textColor;
  final Color hintColor;
  final Color themeColor;
  final Color cardColor;
  final Function(String cardNumber, String expiration, String cvc) valueListener;
  PaymentForm(
      {Key key,
      this.fieldStyle = SchemeFieldStyle.outline,
      this.showIcon = false,
      this.valueListener,
      this.textColor = nearlyBlack,
      this.hintColor = Colors.grey,
      this.themeColor = Colors.blue,
      this.cardColor = Colors.white,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardNumberController = useTextEditingController();
    final expirationController = useTextEditingController();
    final cvcController = useTextEditingController();
    final cardFocus = useFocusNode();
    final expirationFocus = useFocusNode();
    final cvcFocus = useFocusNode();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          textField(
              label: 'Credit Card',
              focusNode: cardFocus,
              nextFocus: expirationFocus,
              iconData: Boxicons.bxCreditCard,
              controller: cardNumberController,
              formatter: ccFormatter,
              onChange: (text) => valueListener(
                  cardNumberController.text, expirationController.text, cvcController.text)),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: textField(
                    label: 'Expiration Date (MM/YY)',
                    focusNode: expirationFocus,
                    nextFocus: cvcFocus,
                    iconData: Boxicons.bxCalendar,
                    controller: expirationController,
                    formatter: expFormatter,
                    onChange: (text) => valueListener(
                        cardNumberController.text, expirationController.text, cvcController.text)),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                width: 150,
                child: textField(
                    label: 'CVC',
                    focusNode: cvcFocus,
                    iconData: Boxicons.bxShieldAlt,
                    controller: cvcController,
                    formatter: amexFormatter,
                    onChange: (text) => valueListener(
                        cardNumberController.text, expirationController.text, cvcController.text)),
              )
            ],
          )
        ],
      ),
    );
  }

  textField(
      {String label,
      FocusNode focusNode,
      FocusNode nextFocus,
      IconData iconData,
      TextEditingController controller,
      TextInputFormatter formatter,
      Function(String text) onChange}) {
    switch (fieldStyle) {
      case SchemeFieldStyle.card:
        // TODO: Handle this case.
        return CardTextField(
          label: label,
          textFocus: focusNode,
          nextFocus: nextFocus,
          iconData: iconData,
          controller: controller,
          inputFormatters: [formatter],
          showIcon: showIcon,
          brandColor: themeColor,
          textColor: textColor,
          hintColor: hintColor,
          inputType: TextInputType.number,
          backgroundColor: cardColor,
          textStyle: textStyle,
          onChange: (text) => onChange(text),
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
          iconData: iconData,
          inputFormatters: [formatter],
          showIcon: showIcon,
          textInputType: TextInputType.number,
          textStyle: textStyle,
          onChange: (text) => onChange(text),
        );
    }
  }
}
