import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskit/onboarding/login.dart';
import 'package:taskit/onboarding/register.dart';

class Login_or_Register extends StatefulWidget {
  const Login_or_Register({Key? key}) : super(key: key);

  @override
  State<Login_or_Register> createState() => _Login_or_RegisterState();
}

class _Login_or_RegisterState extends State<Login_or_Register> {
  TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  bool isSwitched = false;
  void swap() {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  // sign In switch
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        swap();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: isSwitched
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: isSwitched
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),

                                  // sign up switch
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        swap();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: isSwitched
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Register',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: isSwitched
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .tertiary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              Divider(
                                thickness: 2,
                                // height: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 10,
                                  ),
                                  child: isSwitched
                                      ? Register(
                                          fullNameController:
                                              fullNameController,
                                          emailController: emailController,
                                          passwordController:
                                              passwordController)
                                      : Login(
                                          emailController: emailController,
                                          passwordController:
                                              passwordController))
                            ],
                          ),
                        )),
                    const Spacer(),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // signin with phone number
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          width: MediaQuery.of(context).size.width * 2.5 / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sign In With Google',
                                style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // signin with phone number
                        GestureDetector(
                          child: Container(
                              width: MediaQuery.of(context).size.width * 2.5 / 3,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(
                                      FontAwesomeIcons.phone,
                                      size: 20,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Sign In With Phone Number',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
