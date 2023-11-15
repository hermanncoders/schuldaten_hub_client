import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';

Future<void> selectThisDate(BuildContext context, DateTime thisDate) async {
  List<DateTime> availableDates =
      locator<SchooldayManager>().availableDates.value;
  bool selectableDates(DateTime day) {
    dynamic validDate = availableDates.contains(day);
    return validDate;
  }

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: thisDate,
    selectableDayPredicate: selectableDates,
    firstDate: DateTime(2020),
    lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: backgroundColor,
              onPrimary: Color.fromARGB(255, 241, 241, 241),
              onSurface: Colors.deepPurple,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: accentColor, // button text color
              ),
            ),
          ),
          child: child!);
    },
  );
  if (pickedDate != null) {
    locator<SchooldayManager>().setThisDate(pickedDate);
  }
}

Future<DateTime> selectStartDate(
    BuildContext context, DateTime thisDate) async {
  List<DateTime> availableDates =
      locator<SchooldayManager>().availableDates.value;
  bool selectableDates(DateTime day) {
    dynamic validDate = availableDates.contains(day);
    return validDate;
  }

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: thisDate,
    selectableDayPredicate: selectableDates,
    firstDate: DateTime(2020),
    lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: backgroundColor,
              onPrimary: Color.fromARGB(255, 241, 241, 241),
              onSurface: Colors.deepPurple,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: accentColor, // button text color
              ),
            ),
          ),
          child: child!);
    },
  );
  if (pickedDate != null) {
    locator<SchooldayManager>().setStartDate(pickedDate);
    return pickedDate;
  }
  return thisDate;
}

Future<DateTime> selectEndDate(BuildContext context, DateTime thisDate) async {
  List<DateTime> availableDates =
      locator<SchooldayManager>().availableDates.value;
  bool selectableDates(DateTime day) {
    dynamic validDate = availableDates.contains(day);
    return validDate;
  }

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: thisDate,
    selectableDayPredicate: selectableDates,
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: backgroundColor,
              onPrimary: Color.fromARGB(255, 241, 241, 241),
              onSurface: Colors.deepPurple,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: accentColor, // button text color
              ),
            ),
          ),
          child: child!);
    },
  );
  if (pickedDate != null) {
    locator<SchooldayManager>().setEndDate(pickedDate);
    return pickedDate;
  }
  return thisDate;
}
