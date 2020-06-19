import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheme_package/scheme_package.dart' hide Theme;
import 'package:scheme_package/src/textfields/focus_notifier.dart';
import 'package:scheme_package/src/ui/styles.dart';
import 'package:scheme_theme/scheme_theme.dart';

import 'currency_text_editing_controller.dart';
import 'textfield_constants.dart';

class CardTextField extends HookWidget {
	final FocusNode textFocus;
	final FocusNode nextFocus;
	final TextEditingController controller;
	final CurrencyTextFieldController currencyController;
	final Color brandColor;
	final IconData iconData;
	final String label;
	final bool isPassword;
	final bool enabled;
	final bool showIcon;
	final bool disableKeyboard;
	final bool autoFocus;
	final TextInputType inputType;
	final Color textColor;
	final Color hintColor;
	final Color backgroundColor;
	final TextStyle textStyle;
	final int maxLength;
	final Function onGainedFocus;
	final TextInputAction inputAction;
	final Function(String text) onSubmit;
	final Function(String text) onChange;
	final List<TextInputFormatter> inputFormatters;
	final TextCapitalization textCapitalization;
	final List<BoxShadow> boxShadow;
	final double height;
	CardTextField({
		              Key key,
		              @required this.textFocus,
		              this.nextFocus,
		              this.controller,
		              this.boxShadow,
		              @required this.brandColor,
		              @required this.iconData,
		              @required this.label,
		              this.isPassword = false,
		              this.enabled = true,
		              this.disableKeyboard = false,
		              this.autoFocus = false,
		              this.inputType = TextInputType.visiblePassword,
		              this.textColor = nearlyBlack,
		              this.hintColor = Colors.grey,
		              this.backgroundColor = Colors.white,
		              this.textStyle,
		              this.maxLength,
		              this.onSubmit,
		              this.onChange,
		              this.onGainedFocus,
		              this.inputAction = TextInputAction.done,
		              this.inputFormatters,
		              this.textCapitalization = TextCapitalization.none,
		              this.height = 72,
		              this.showIcon = false,
		              this.currencyController,
	              }) : super(key: key);



	final FocusNotifier focusNotifier = FocusNotifier();

	@override
	Widget build(BuildContext context) {

		final mainStream = useStream<bool>(focusNotifier.mainStream(textFocus));
		final nextStream = useStream<bool>(focusNotifier.mainStream(textFocus));

		return Container(
			height: height,
			padding: EdgeInsets.only(left: 16, right: 16),
			decoration: BoxDecoration(
					color: backgroundColor,
					boxShadow: boxShadow ??
							wideShadow,
					borderRadius: BorderRadius.circular(8)),
			child: Center(
				child: Theme(
					data: Theme.of(context).copyWith(
						primaryColor: brandColor,
					),
					child: TextField(
						enabled: enabled,
						focusNode: textFocus,
						maxLength: maxLength,
						autofocus: autoFocus,
						keyboardType: inputType,
						textInputAction: inputAction,
						inputFormatters: inputFormatters,
						textCapitalization: textCapitalization,
						onChanged: (text) => onChange != null ? onChange(text) : null,
						onSubmitted: (text) {
							if (nextFocus != null && !disableKeyboard) fieldFocusChange(context, textFocus, nextFocus);
							else dismissKeyboardWithContext(context);

							if (onSubmit != null) onSubmit(text);
						},
						style: textStyle == null
								? schemeTitle1.copyWith(color: textColor)
								: textStyle.copyWith(color: textColor),
						maxLines: 1,
						cursorColor: brandColor,
						controller: currencyController ?? controller,
						decoration: showIcon ? inputWithIcon(mainStream.data) : inputNoIcon(mainStream.data),
						obscureText: isPassword,
					),
				),
			),
		);
	}

	inputWithIcon(bool hasFocus) {
		return InputDecoration(
			icon: Icon(
				iconData,
				color: hasFocus ? brandColor : textColor,
			),
			labelStyle: schemeTitle1.copyWith(
					color: hasFocus ? brandColor : textColor.withOpacity(0.55)),
			border: InputBorder.none,
			contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
			labelText: label,
		);
	}

	inputNoIcon(bool hasFocus) {
		return InputDecoration(
			labelStyle: schemeTitle1.copyWith(
					color: hasFocus ? brandColor : textColor.withOpacity(0.55)),
			border: InputBorder.none,
			contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
			labelText: label,
		);
	}
}