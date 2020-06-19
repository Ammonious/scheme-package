import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';

class LoginForm extends StatelessWidget {
  final SchemeFieldStyle fieldStyle;
  final double spacing;
  LoginForm({Key key, this.fieldStyle = SchemeFieldStyle.card, this.spacing = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userController = useTextEditingController();
    final passwordController = useTextEditingController();
    final userFocus = useFocusNode();
    final passwordFocus = useFocusNode();

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          SchemeTextField(
              fieldStyle: fieldStyle,
              controller: userController,
              focusNode: userFocus,
              nextFocus: passwordFocus),
	        SizedBox(height: spacing),
	        SchemeTextField(
			        fieldStyle: fieldStyle,
			        controller: passwordController,
			        focusNode: passwordFocus
	        )
        ],
      ),
    );
  }
}
