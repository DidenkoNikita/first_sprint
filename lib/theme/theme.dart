import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
  scaffoldBackgroundColor: const Color.fromRGBO(51, 51, 51, 1),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    )
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromRGBO(51, 51, 51, 1),
    elevation: 0, 
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
);