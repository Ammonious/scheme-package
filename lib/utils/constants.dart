import 'package:flutter/material.dart';

const String SORTABLE_DATE = 'yyyy-MM-dd';
const String SORTABLE_DATE_TIME = 'yyyy-MM-dd h:mm a';
const String READABLE_DATE = 'MMM d, yyyy';
const String READABLE_DATE_TIME = 'h:mm a MMM d, yyyy';
const String FULL_DATE = 'EEEE, MMM d, yyyy';
const String DAY = 'EEEE';


// ignore: slash_for_doc_comments
/********************************
* ? GLOBAL SIZES
*********************************/


double get appbarHeight => AppBar().preferredSize.height;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double topPadding(BuildContext context) => MediaQuery.of(context).padding.top;

double appbarWithPadding(BuildContext context) => AppBar().preferredSize.height + topPadding(context);



Duration get normalDuration => Duration(milliseconds: 350);

enum ConnectivityStatus { CONNECTED, OFFLINE }


 const Color notWhite = Color(0xFFEDF0F2);
 const Color nearlyWhite = Color(0xFFFAFAFA);
 const Color white = Color(0xFFFFFFFF);
 const Color background = Color(0xFFF2F3F8);
 const Color darkBackground = Color(0xFF0F0F0F);
 const Color nearlyBlack = Color(0xFF213333);


 List<BoxShadow> largeShadow = [
	BoxShadow(blurRadius: 25.50, color: Colors.black.withOpacity(0.46), offset: Offset(0, 4))
];
 List<BoxShadow> wideShadow = [
	BoxShadow(blurRadius: 45.50, color: Colors.black.withOpacity(0.25), offset: Offset(0, 4))
];
 List<BoxShadow> normalShadow = [
	BoxShadow(blurRadius: 4.5, color: Colors.black.withOpacity(0.25), offset: Offset(0, 2))
];
 List<BoxShadow> liftedShadow = [
	BoxShadow(blurRadius: 7.5, color: Colors.black.withOpacity(0.35), offset: Offset(0, 4))
];


