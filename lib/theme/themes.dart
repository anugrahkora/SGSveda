import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightThemeData(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  return ThemeData(
    fontFamily: 'Metropolis',
    scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Color(0xff181713)),
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Color(0xff141A39),
            fontFamily: 'Metropolis',
            fontSize: 16,
            fontWeight: FontWeight.bold)),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Color.fromARGB(255, 33, 33, 33),
      ),
      headlineMedium: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Color.fromARGB(255, 52, 52, 52),
      ),
      titleLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Color(0xff141A39),
      ),
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: Color(0xff141A39),
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Color(0xff141A39),
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: Color(0xff141A39),
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: Color(0xff515869),
      ),
      labelSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Color.fromARGB(255, 173, 175, 187),
      ),
      labelMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Color.fromARGB(255, 13, 13, 13),
      ),
      labelLarge: TextStyle(
        fontSize: 21.0,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: Color.fromARGB(255, 24, 23, 37),
      ),
    ),
  );
}
