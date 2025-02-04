import 'package:flutter/material.dart';
import 'package:taskit/Components/form_tf.dart';
import 'package:taskit/Dashboard.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  Theme.of(context).colorScheme.secondary),
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
          onPressed: () {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ));
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Login',
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
