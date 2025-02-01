import 'package:flutter/material.dart';
import 'package:taskit/Components/form_tf.dart';
import 'package:taskit/styles/checkbox_style.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  Register({
    Key? key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);
  TextEditingController fullNameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isObscure = false;

  showPassword(bool? value) {
    setState(() {
      isObscure = value ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTf(
          controller: widget.fullNameController,
          obscureText: false,
          hint: 'Enter Fullname',
        ),
        const SizedBox(
          height: 20,
        ),
        FormTf(
          controller: widget.emailController,
          obscureText: false,
          hint: 'Enter Email',
        ),
        const SizedBox(
          height: 20,
        ),
        FormTf(
          controller: widget.passwordController,
          obscureText: !isObscure,
          hint: 'Enter Password',
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: isObscure,
              onChanged: (value) => showPassword(value),
              activeColor: Theme.of(context).colorScheme.tertiary,
              checkColor: Theme.of(context).colorScheme.tertiary,
              fillColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            const Text('Show Password'),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        MaterialButton(
          height: 70,
          minWidth: 450,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          color: Theme.of(context).colorScheme.surface,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Register',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
