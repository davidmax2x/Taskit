import 'package:flutter/material.dart';

class Form_tf extends StatelessWidget {
  Form_tf({
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
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        border: const OutlineInputBorder(
          gapPadding: 5,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
