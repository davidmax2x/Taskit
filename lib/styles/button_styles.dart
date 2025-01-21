import 'package:flutter/material.dart';

var authButtonStyle = const ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(
    Colors.black,
  ),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  ),
  padding: WidgetStatePropertyAll(
    EdgeInsets.all(10),
  ),
  textStyle: WidgetStatePropertyAll(
    TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
);
