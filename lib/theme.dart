import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/constants/constants.dart';

ThemeData themes() {
  // const Locale locale = Locale('en');
  return ThemeData.light().copyWith(
    primaryColor: Colors.green,
    appBarTheme: const AppBarTheme(
      backgroundColor: Constants.primaryColor,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: "Roboto-Regular",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: "Roboto-Regular",
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontFamily: "Roboto-Medium",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: "Roboto-Regular",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xff1f1f1f),
      ),
    ),
    colorScheme: const ColorScheme(
      primary: Colors.green,
      onPrimary: Constants.primaryColor,
      background: Colors.black,
      onBackground: Colors.black,
      secondary: Colors.black,
      onSecondary: Colors.black,
      error: Colors.black,
      onError: Colors.black,
      surface: Colors.black,
      onSurface: Colors.black,
      brightness: Brightness.light,
    ),
  );
}
