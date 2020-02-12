import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/forms/form_constants.dart';
import 'package:scheme_package/src/textfields/card_textfield.dart';
import 'package:scheme_package/src/textfields/custom_text_field.dart';

class PaymentForm extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController expirationController;
  final TextEditingController cvcController;
  final FormFieldStyle fieldStyle;
  final TextStyle textStyle;
  final bool showIcon;
  final Color textColor;
  final Color hintColor;
  final Color themeColor;
  final Color cardColor;
  PaymentForm(
      {Key key,
     @required this.cardNumberController,
     @required this.expirationController,
     @required this.cvcController,
      this.fieldStyle = FormFieldStyle.Outline,
      this.showIcon = false,
      this.textColor = nearlyBlack,
      this.hintColor = Colors.grey,
      this.themeColor = Colors.blue, this.cardColor = Colors.white, this.textStyle})
      : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
    FocusNode cardFocus = FocusNode();
   FocusNode expirationFocus = FocusNode();
   FocusNode cvcFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          textField('Credit Card', cardFocus, expirationFocus, Boxicons.bxCreditCard,
              widget.cardNumberController, ccFormatter),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(child: textField('Expiration Date (MM/YY)', expirationFocus, cvcFocus, Boxicons.bxCalendar,
                  widget.expirationController, expFormatter),),
              SizedBox(
                width: 16,
              ),
              Container(
                width: 150,
                child: textField(
                    'CVC', cvcFocus, null, Boxicons.bxShieldAlt, widget.cvcController,amexFormatter),
              )
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
    TextInputFormatter formatter,
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
          inputFormatters: [formatter],
          showIcon: widget.showIcon,
          brandColor: widget.themeColor,
          textColor: widget.textColor,
          hintColor: widget.hintColor,
          inputType: TextInputType.number,
          backgroundColor: widget.cardColor,
          textStyle: widget.textStyle,
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
          inputFormatters: [formatter],
          showIcon: widget.showIcon,
          textInputType: TextInputType.number,
          textStyle: widget.textStyle,
        );
    }
  }
}
