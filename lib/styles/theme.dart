import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  hintColor: const Color.fromARGB(255, 44, 44, 44),
  colorScheme: const ColorScheme.light(
    surface: Color.fromRGBO(234, 224, 213, 1),
    primary: Color.fromRGBO(233, 236, 239, 1),
    secondary: Color.fromRGBO(52, 58, 64, 1),
    tertiary: Color.fromRGBO(248, 249, 250, 1),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      surface: Color.fromRGBO(10, 9, 8, 1),
      primary: Color.fromRGBO(94, 80, 63, 1),
      secondary: Color.fromRGBO(234, 224, 213, 1),
      tertiary: Color.fromRGBO(34, 51, 59, 1)),
);
