import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/icons/constants/box_icons.dart';
import 'package:scheme_package/src/textfields/keyboard_avoider.dart';
import 'package:scheme_theme/scheme_theme.dart' hide SchemeTextField;


class ContactForm extends HookWidget {
	final bool showButton;
	final String tag;
	final SchemeFieldStyle fieldStyle;
	final TextStyle textStyle;
	final Color themeColor;
	final Color textColor;
	final Function(TextEditingController nameController,
			TextEditingController emailController,
			TextEditingController phoneController,
			TextEditingController messageController,
			String tag) onSubmit;
	ContactForm(   {this.fieldStyle = SchemeFieldStyle.card, this.textStyle,
		                 Key key,
		                 this.onSubmit,
		                 this.showButton = false,
		                 this.tag,
		               this.textColor = nearlyBlack,
		              this.themeColor = Colors.blueAccent,
	                 }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final nameController = useTextEditingController();
		final phoneController = useTextEditingController();
		final emailController = useTextEditingController();
		final messageController = useTextEditingController();
		final nameNode = useFocusNode();
		final phoneNode = useFocusNode();
		final emailNode = useFocusNode();
		final messageNode = useFocusNode();
		final refresh = useState();

		return KeyboardAvoider(
		  child: Column(
		  	mainAxisSize: MainAxisSize.min,
		  	children: <Widget>[
		  		SizedBox(
		  			height: 16,
		  		),
		  		SchemeTextField(
		  			controller: nameController,
		  			focusNode: nameNode,
		  			nextFocus: phoneNode,
		  			iconData: Boxicons.bxUser,
		  			label: 'First and Last Name',
		  			inputType: TextInputType.text,
		  			inputAction: TextInputAction.next,
		  			hintColor: textColor,
		  			textColor: textColor,
		  			themeColor: themeColor,
		  		),
		  		SizedBox(
		  			height: 16,
		  		),
		  		SchemeTextField(
		  			controller: phoneController,
		  			focusNode: phoneNode,
		  			nextFocus: emailNode,
		  			iconData: BoxIcon.bxPhone,
		  			inputFormatters: [phoneFormatter],
		  			inputType: TextInputType.phone,
		  			inputAction: TextInputAction.next,
		  			maxLength: 12,
		  			label: 'Phone (Optional)',
		  			hintColor: textColor,
		  			textColor: textColor,
		  			themeColor: themeColor,
		  		),
		  		SizedBox(
		  			height: 16,
		  		),
		  		SchemeTextField(
		  			controller: emailController,
		  			focusNode: emailNode,
		  			nextFocus: messageNode,
		  			iconData: Boxicons.bxEnvelope,
		  			inputType: TextInputType.emailAddress,
		  			inputAction: TextInputAction.next,
		  			label: 'Email',
		  			hintColor: textColor,
		  			textColor: textColor,
		  			themeColor: themeColor,
		  		),
		  		SizedBox(
		  			height: 32,
		  		),
		  		AnimatedContainer(
		  			duration: normalDuration,
		  			decoration: BoxDecoration(
		  				color: Colors.white,
		  				borderRadius: BorderRadius.circular(8),
		  				boxShadow: [
		  					BoxShadow(
		  							blurRadius: 25.50, color: Colors.black.withOpacity(0.13), offset: Offset.zero)
		  				],
		  			),
		  			child: GestureDetector(
		  				onTap: () => dismissKeyboardWithContext(context),
		  				child: ClipRRect(
		  					borderRadius: BorderRadius.circular(25),
		  					child: AnimatedContainer(
		  						duration: Duration(milliseconds: 300),
		  						padding: EdgeInsets.all(16.0),
		  						margin: EdgeInsets.only(left: 16, right: 16),
		  						constraints: BoxConstraints(minHeight: 250, maxHeight: 250),
		  						color: Colors.white,
		  						child: TextField(
		  							maxLines: null,
		  							controller: messageController,
		  							focusNode: messageNode,
		  							textInputAction: TextInputAction.newline,
		  							textCapitalization: TextCapitalization.sentences,
		  							style: textStyle,
		  							enableSuggestions: true,
		  							cursorColor: themeColor,
		  							decoration:
		  							InputDecoration(border: InputBorder.none, hintText: "Enter your message..."),
		  						),
		  					),
		  				),
		  			),
		  		),
		  		Visibility(
		  			visible: showButton,
		  			child: Padding(
		  				padding: EdgeInsets.only(
		  					top: 32,
		  				),
		  				child: Align(
		  					alignment: Alignment.centerRight,
		  					child: GradientButton(
		  						height: 60,
		  						width: 200,
		  						superEllipseShape: true,
		  						label: 'Send Message',
		  						color: themeColor,
		  						textStyle: textStyle.copyWith(color: themeColor.textColor),
		  						boxShadow: normalShadow,
		  						onTap: () => onSubmitForm(nameController, emailController, phoneController, messageController, tag, refresh),
		  					),
		  				),
		  			),
		  		)
		  	],
		  ),
		);
	}

	onSubmitForm(
			TextEditingController nameController,
			TextEditingController emailController,
			TextEditingController phoneController,
			TextEditingController messageController,
			String tag,
			ValueNotifier refresh) {
		clearForm(nameController, emailController, phoneController, messageController, refresh);
		onSubmit(
				nameController,
				emailController,
				phoneController,
				messageController,
				tag);
	}

	clearForm(
			TextEditingController nameController,
			TextEditingController emailController,
			TextEditingController phoneController,
			TextEditingController messageController,
			ValueNotifier refresh) {
		nameController.text = '';
		emailController.text = '';
		phoneController.text = '';
		messageController.text = '';
		refresh.value = true;
	}
}