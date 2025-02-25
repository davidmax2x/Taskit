import 'package:flutter/material.dart';

class RegularTextField extends StatelessWidget {
  const RegularTextField({super.key, required this.hint, required this.controller});
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiary,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        prefixIcon: const Icon(Icons.text_fields, color: Colors.grey),
      ),
      style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
    );
  }
}
