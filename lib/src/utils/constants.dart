import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scheme_theme/scheme_theme.dart';

const String SORTABLE_DATE = 'yyyy-MM-dd';
const String SORTABLE_DATE_TIME = 'yyyy-MM-dd HH:mm';
const String READABLE_DATE = 'MMM d, yyyy';
const String READABLE_DATE_TIME = 'h:mm a MMM d, yyyy';
const String FULL_DATE = 'EEEE, MMM d, yyyy';
const String DAY = 'EEEE';


  const String placeholder =
    'https://firebasestorage.googleapis.com/v0/b/craq-1cbd8.appspot.com/o/profile_placeholder.png?alt=media&token=4278c2b5-9b0a-4e91-8c11-7bd6d3959cf3';

// ignore: slash_for_doc_comments
/********************************
 * ? GLOBAL SIZES
 *********************************/






getDateTime({String sortableDateTime, String sortableDate}) {
  DateTime dateTime = DateTime.tryParse(sortableDateTime);
  if (dateTime == null) dateTime = DateTime.tryParse(sortableDate);
  if (dateTime == null) dateTime = DateTime.now();
  return DateFormat(READABLE_DATE_TIME).format(dateTime);
}

getReadableDate({String sortableDate}) {
  DateTime dateTime = DateTime.tryParse(sortableDate);
  if (dateTime == null) dateTime = DateTime.now();
  return DateFormat(READABLE_DATE).format(dateTime);
}


const defaultIconTheme = IconThemeData(color: Colors.black,size: 24,opacity: 1.0);
const selectedIconTheme = IconThemeData(color: Colors.black,size: 24,opacity: 1.0);


TextStyle get defaultTitle => GoogleFonts.libreFranklin(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    textStyle: TextStyle(color: nearlyBlack, letterSpacing: 1.1));

futureBuilderShowLoading(ConnectionState state) {
  switch (state) {
    case ConnectionState.none:
      // TODO: Handle this case.
      return false;
    case ConnectionState.waiting:
      // TODO: Handle this case.
      return true;
    case ConnectionState.active:
      // TODO: Handle this case.
      return true;
    case ConnectionState.done:
      // TODO: Handle this case.
      return false;
  }
}
