import 'package:flutter/material.dart';

ThemeData myTheme() {
  return ThemeData(
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 18,
          fontFamily: 'Robot Condensed',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryColor: Colors.red,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto Condensed',
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )),
      ));
}
