import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/global_widgets/auto_size_text.dart';
import 'package:scheme_package/src/global_widgets/images/profile_image.dart';
import 'package:scheme_package/src/ui/styles.dart';
import 'package:scheme_theme/scheme_theme.dart';

class DropDownFormField extends FormField<dynamic> {
	final String titleText;
	final String hintText;
	final bool required;
	final String errorText;
	final dynamic value;
	final List dataSource;
	final String textField;
	final String valueField;
	final Function onChanged;
	final Color hintColor;
	final Color selectedColor;
	final BorderRadius borderRadius;
	final double borderWidth;
	final IconData iconData;
	final Color iconColor;
	final bool showIcon;
	final bool noBorder;
	final Color activeColor;
	final TextStyle hintStyle;
	final Color borderColor;
	final bool enabled;
	final bool alignDropdown;
	final String imageUrl;
	final bool isDense;
	final bool isExpanded;
	final double imageSize;
	DropDownFormField(
			{this.imageUrl,
				this.enabled,
				this.isDense = true,
				this.isExpanded = true,
				this.borderColor,
				this.activeColor = Colors.blue,
				FormFieldSetter<dynamic> onSaved,
				FormFieldValidator<dynamic> validator,
				bool autovalidate = false,
				this.iconData,
				this.iconColor,
				this.hintStyle,
				this.noBorder = false,
				this.showIcon = false,
				this.alignDropdown = false,
				this.titleText = 'Title',
				this.hintText = 'Select one option',
				this.required = false,
				this.errorText = 'Please select one option',
				this.value,
				this.dataSource,
				this.textField,
				this.valueField,
				this.selectedColor,
				this.hintColor,
				this.borderWidth = 1,
				this.imageSize,
				this.onChanged,
				this.borderRadius = const BorderRadius.all(Radius.circular(4)),
			}) : super(
		onSaved: onSaved,
		validator: validator,
		autovalidate: autovalidate,
		builder: (FormFieldState<dynamic> state) {
			return Container(
				child: Center(
					child: InputDecorator(
						decoration: showIcon
								? inputWithIcon(
								noBorder: noBorder,
								borderRadius: borderRadius,
								borderWidth: borderWidth,
								label: titleText,
								iconColor: iconColor,
								borderColor: borderColor,
								iconData: iconData,
								activeColor: activeColor,
								hintColor: hintColor)
								: inputNoIcon(
								noBorder: noBorder,
								borderRadius: borderRadius,
								borderWidth: borderWidth,
								borderColor: borderColor,
								activeColor: activeColor,
								label: titleText,
								hintColor: hintColor),
						child: DropdownButtonHideUnderline(
							child: ButtonTheme(
								padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
								alignedDropdown: alignDropdown,
								child: DropdownButton<dynamic>(
									icon: Icon(
										Boxicons.bxChevronDown,
										color: hintColor,
									),
									isExpanded: isExpanded,
									isDense: isDense,
									hint: imageUrl != null
											? inputWithImage(
											imageUrl: imageUrl,
											hintColor: hintColor,
											hintStyle: hintStyle,
											imageSize: imageSize,
											hintText: hintText)
											: AutoSizeText(
										hintText,
										maxLines: 1,
										style: hintStyle != null
												? hintStyle.copyWith(color: hintColor)
												: schemeTitle1.copyWith(color: hintColor),
									),
									value: value == '' ? null : value,
									onChanged: enabled
											? (dynamic newValue) {
										state.didChange(newValue);
										onChanged(newValue);
									}
											: null,
									items: dataSource.map((item) {
										return DropdownMenuItem<dynamic>(
											value: item[valueField],
											child: Container(height: 60,
												padding: EdgeInsets.only(left: 0, right: 0),
												decoration: BoxDecoration(
														color: hintText == item[textField]
																? Colors.grey.withOpacity(0.25)
																: Colors.transparent,
														borderRadius: BorderRadius.circular(12)),
												child: Row(
													children: <Widget>[
														imageUrl != null
																? ProfileImage(
															url: item[valueField].url ?? placeholder,
															boxShadow: normalShadow,
															size: 24,
														)
																: AnimatedOpacity(
															duration: normalDuration,
															opacity: hintText == item[textField] ? 1.0 : 0.0,
															child: Container(
																margin: EdgeInsets.only(left: 8),
																height: 10,
																width: 10,
																decoration: BoxDecoration(
																		borderRadius: BorderRadius.circular(5),
																		gradient: schemeGradient(color: activeColor)),
															),
														),
														SizedBox(
															width: 10,
														),
														Expanded(child: 	AutoSizeText(
															item[textField] ?? '',maxLines: 1,
															style:hintStyle ?? schemeTitle1,
														),)

													],
												),
											),
										);
									}).toList(),
								),
							),
						),
					),
				),
			);
		},
	);


	static setBorder(
			{bool noBorder,
				bool isFocus,
				BorderRadius borderRadius,
				Color borderColor,
				Color hintColor,
				double borderWidth}) {
		if (noBorder) {
			return InputBorder.none;
		}
		return OutlineInputBorder(
				borderRadius: borderRadius,
				borderSide: BorderSide(color: borderColor ?? hintColor, width: isFocus ? 2 : borderWidth));
	}

	static setMenuBorderRadius(List dataSource, var item) {
		return dataSource.indexOf(item) == 0
				? BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
				: dataSource.indexOf(item) == dataSource.length - 1
				? BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
				: BorderRadius.circular(0);
	}


	static inputWithImage({String imageUrl, String hintText, TextStyle hintStyle, Color hintColor,double imageSize = 24}) {
		return Row(mainAxisAlignment: MainAxisAlignment.start,
			children: <Widget>[
				ProfileImage(
					size: imageSize,
					url: imageUrl,
					boxShadow: normalShadow,
				),
				SizedBox(
					width: 16,
				),
				AutoSizeText(
					hintText,
					maxLines: 1,
					style: hintStyle != null
							? hintStyle.copyWith(color: hintColor)
							: schemeTitle1.copyWith(color: hintColor),
				),
			],
		);
	}

	static inputNoIcon(
			{BorderRadius borderRadius,
				Color hintColor,
				Color activeColor,
				double borderWidth,
				Color borderColor,
				String label,
				bool noBorder}) {
		return InputDecoration(
			border: setBorder(
					noBorder: noBorder,
					isFocus: false,
					borderRadius: borderRadius,
					borderWidth: borderWidth,
					borderColor: borderColor,
					hintColor: hintColor),
			focusedBorder: setBorder(
					noBorder: noBorder,
					isFocus: false,
					borderColor: borderColor,
					borderRadius: borderRadius,
					borderWidth: borderWidth,
					hintColor: hintColor),
			enabledBorder: setBorder(
					noBorder: noBorder,
					isFocus: false,
					borderColor: borderColor,
					borderRadius: borderRadius,
					borderWidth: borderWidth,
					hintColor: hintColor),
			labelText: label,
			labelStyle: schemeTitle1.copyWith(color: hintColor ?? Colors.white),
			filled: false,
		);
	}

	static inputWithIcon(
			{BorderRadius borderRadius,
				Color hintColor,
				Color activeColor,
				double borderWidth,
				String label,
				IconData iconData,
				Color iconColor,
				Color borderColor,
				bool noBorder}) {
		return InputDecoration(
			icon: Icon(
				iconData,
				color: iconColor,
			),
			border: setBorder(
					noBorder: noBorder,
					isFocus: false,
					borderRadius: borderRadius,
					borderColor: borderColor,
					borderWidth: borderWidth,
					hintColor: hintColor),
			focusedBorder: setBorder(
					noBorder: noBorder,
					isFocus: false,
					borderColor: borderColor,
					borderRadius: borderRadius,
					borderWidth: borderWidth,
					hintColor: hintColor),
			enabledBorder: setBorder(
					noBorder: noBorder,
					isFocus: false,
					borderRadius: borderRadius,
					borderWidth: borderWidth,
					borderColor: borderColor,
					hintColor: hintColor),
			labelText: label,
			labelStyle: schemeTitle1.copyWith(color: hintColor ?? Colors.white),
			filled: false,
		);
	}
}