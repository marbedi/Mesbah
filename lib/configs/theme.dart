import 'package:flutter/material.dart';

const Color textColor = Colors.black87;

final lightTheme = ThemeData.light().copyWith(
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color>(const Color(0xff825AE3)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'vazir'),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: Color(0xffC4C4C4),
      ),
    ),
  ),
  scaffoldBackgroundColor: Color(0xffF5F9FA),
  textTheme: TextTheme(
    labelSmall: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w300,
        fontSize: 14,
        fontFamily: 'vazir'),
    labelMedium: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: 'vazir'),
    bodySmall: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: 'vazir'),
    labelLarge: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w900,
        fontSize: 20,
        fontFamily: 'vazir'),
    headlineLarge: TextStyle(fontFamily: 'vazir'),
    headlineMedium: TextStyle(fontFamily: 'vazir'),
    headlineSmall: TextStyle(fontFamily: 'vazir'),
  ),
  colorScheme: const ColorScheme.light(
      primary: Color(0xff825AE3),
      background: Color(0xffefefef),
      surface: Colors.white,
      onSurface: Colors.black,
      secondaryContainer: Color(0xffE8F1F5)),
);
