import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'package:scheme_theme/scheme_theme.dart';

Future<DateTime> showDateTimePicker(BuildContext context,
    {DateTime initialDate,
    DateTime earliestDate,
    DateTime latestDate,
    Color themeColor,
    double width,
    double height}) {
  return showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: earliestDate ?? DateTime(DateTime.now().year - 1),
    lastDate: latestDate ?? DateTime(DateTime.now().year + 1),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
            primaryColor: themeColor ?? Colors.blue, accentColor: themeColor ?? Colors.blue),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: height ?? screenHeight * 0.75,
                width: width ?? screenWidth * 0.4,
                child: child),
          ],
        ),
      );
    },
  );
}

get yesterdayString => DateFormat(READABLE_DATE)
    .format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));

get yesterday => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

Duration daysUntil({String today, String day}){
  DateTime dayOne = DateTime.tryParse(today);
  DateTime dayTwo = DateTime.tryParse(day);
 return dayTwo.difference(dayOne);
}
