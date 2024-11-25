import 'package:flutter/material.dart';
import 'package:taskit/Components/form_tf.dart';
import 'package:taskit/Dashboard.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  TextEditingController user_name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form_tf(
                  obscureText: false,
                  hint: 'Enter Password',
                  controller: user_name_controller,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form_tf(
                  obscureText: true,
                  hint: 'Enter Password',
                  controller: password_controller,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: 60,
                  minWidth: width - 10,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Dashboard()));
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
