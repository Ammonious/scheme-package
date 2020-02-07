import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scheme_package/src/utils/constants.dart';
import 'package:scheme_package/src/utils/color_tools.dart';
import 'package:scheme_package/src/ui/gradients.dart';
import 'package:scheme_package/src/ui/styles.dart';
class CustomBottomBar extends StatelessWidget {
	final Function onTapPrimary;
	final Function onTapSecondary;
	final String primaryTitle;
	final String secondaryTitle;
	final TextStyle stylePrimary;
	final TextStyle styleSecondary;
	final Color primaryColor;
	final Color secondaryColor;
	final bool isLoading;
	final bool secondaryEnabled;
	final double height;
	final IconData primaryIcon;
	final String heroTagPrimary;
	final String heroTagSecondary;
	CustomBottomBar({
		                Key key,
		                this.onTapPrimary,
		                this.onTapSecondary,
		                this.primaryTitle = '',
		                this.secondaryTitle = '',
		                this.stylePrimary,
		                this.styleSecondary,
		                this.primaryColor = Colors.blue,
		                this.secondaryColor = nearlyBlack,
		                this.isLoading = false,
		                this.secondaryEnabled = false,
		                this.height = 60,
		                this.primaryIcon,
		                this.heroTagPrimary = 'primary',
		                this.heroTagSecondary = 'secondary',
	                }) : super(key: key);

	@override
	Widget build(BuildContext context) {
		// TODO: implement build
		return SafeArea(
		  child: Container(
		  	height: height,
		  	decoration: BoxDecoration(
		  			boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -2))],
		  			gradient: LinearGradient(
		  					begin: Alignment.centerLeft,
		  					end: Alignment.centerRight,
		  					stops: [0.1, 0.5],
		  					colors: [Colors.white, background])),
		  	child: Row(
		  		children: <Widget>[
		  			Hero(
		  				tag: heroTagSecondary,
		  				child: Container(
		  					width: MediaQuery.of(context).size.width / 2,
		  					height: height,
		  					child: Material(
		  						color: Colors.transparent,
		  						child: InkWell(
		  							onTap: () {
		  								if (onTapSecondary != null) {
		  									onTapSecondary();
		  								}
		  							},
		  							borderRadius: BorderRadius.all(Radius.circular(100)),
		  							splashColor: primaryColor.withOpacity(0.2),
		  							child: Container(
		  								width: MediaQuery.of(context).size.width / 2,
		  								child: Visibility(
		  									visible: secondaryEnabled,
		  									child: Center(
		  										child: Text(
		  											secondaryTitle,
		  											style: styleSecondary != null
		  													? styleSecondary.copyWith(color: secondaryColor.textColor)
		  													: button.copyWith(color: secondaryColor.textColor),
		  										),
		  									),
		  								),
		  							),
		  						),
		  					),
		  				),
		  			),
		  			Material(
		  				color: Colors.transparent,
		  				child: Hero(
		  					tag: heroTagPrimary,
		  					child: Container(
		  							height: height,
		  							width: MediaQuery.of(context).size.width / 2,
		  							decoration: BoxDecoration(
		  								boxShadow: [
		  									BoxShadow(
		  											blurRadius: 10.25,
		  											color: Colors.white.withOpacity(0.4),
		  											offset: Offset.zero)
		  								],
		  								borderRadius: BorderRadius.only(topLeft: Radius.circular(24)),
		  								gradient: createGradient(color: primaryColor),
		  							),
		  							child: Material(
		  								color: Colors.transparent,
		  								child: InkWell(
		  									borderRadius: BorderRadius.only(topLeft: Radius.circular(24)),
		  									onTap: () {
		  										if (onTapPrimary != null) {
		  											onTapPrimary();
		  										}
		  									},
		  									child: Container(
		  										height: height,
		  										width: MediaQuery.of(context).size.width / 2,
		  										decoration: BoxDecoration(
		  												borderRadius: BorderRadius.only(topLeft: Radius.circular(24))),
		  										child: Center(
		  											child: Row(
		  												mainAxisSize: MainAxisSize.min,
		  												crossAxisAlignment: CrossAxisAlignment.center,
		  												children: <Widget>[
		  													Visibility(
		  															visible: primaryIcon != null,
		  															child: Icon(
		  																primaryIcon ?? Boxicons.bxDiamond,
		  																color: TextColor(primaryColor),
		  															)),
		  													SizedBox(
		  														width: primaryIcon != null ? 12 : 0,
		  													),
		  													Text(
		  														primaryTitle,
		  														style: stylePrimary != null
		  																? stylePrimary.copyWith(color: primaryColor.textColor)
		  																: button.copyWith(color: primaryColor.textColor),
		  													),
		  												],
		  											),
		  										),
		  									),
		  								),
		  							)),
		  				),
		  			)
		  		],
		  	),
		  ),
		);
	}
}