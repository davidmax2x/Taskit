import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  hintColor: const Color(0xFF6C757D), // A medium gray for hints
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF8F9FA), // A very light gray for the surface
    primary: Color(0xFF007BFF), // A vibrant blue for primary actions
    secondary: Color(0xFF6C757D), // A medium gray for secondary elements
    tertiary: Color(0xFFFFD166), // A soft yellow for accents
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF343A40), // A dark gray for the surface
    primary: Color(0xFF007BFF), // The same vibrant blue as in light theme
    secondary: Color(0xFFADB5BD), // A light gray for secondary elements
    tertiary: Color(0xFFFFD166), // The same soft yellow for accents
  ),
);

