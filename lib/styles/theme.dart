import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  hintColor: const Color.fromARGB(255, 44, 44, 44),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 248, 242, 242),
    primary: Color.fromARGB(255, 44, 44, 44),
    secondary: Colors.black,
    tertiary: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.black ,
    primary: Colors.grey.shade900,
    secondary: Colors.white,
  ),
);
