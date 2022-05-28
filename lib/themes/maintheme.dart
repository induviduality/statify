import 'package:flutter/material.dart';

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  primary: const Color.fromARGB(255, 7, 194, 113),
  minimumSize: const Size(100, 48),
  textStyle: const TextStyle(
    fontFamily: 'Gotham',
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: Colors.white,
  ),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
        backgroundColor: const Color.fromARGB(9, 10, 12, 255),
        primaryColor: const Color.fromARGB(255, 7, 194, 113),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 7, 194, 113),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(9, 10, 12, 255),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: elevatedButtonStyle,
        ),
        fontFamily: 'Gotham',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          headline2: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          headline3: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          headline4: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          headline5: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          headline6: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          subtitle1: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          subtitle2: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          bodyText2: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ));
  }
}
