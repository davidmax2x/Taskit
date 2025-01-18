import 'package:flutter/material.dart';

var authButtonStyle = const ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(
    Colors.black,
  ),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  ),
  padding: MaterialStatePropertyAll(
    EdgeInsets.all(10),
  ),
  textStyle: MaterialStatePropertyAll(
    TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
);
