// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FormTf extends StatelessWidget {
  FormTf({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.hint,
  }) : super(key: key);
  TextEditingController controller = TextEditingController();
  final bool obscureText;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      obscureText: obscureText,
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.secondary,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hint,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
