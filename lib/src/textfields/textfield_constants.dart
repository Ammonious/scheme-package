
 import 'package:flutter/material.dart';

fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
	currentFocus.unfocus();
	FocusScope.of(context).requestFocus(nextFocus);
}

 dismissKeyboardWithContext(BuildContext context) =>
		 FocusScope.of(context).requestFocus(FocusNode());