import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Edit%20pages/Edit_nootes.dart';
import 'package:taskit/Providers/NoteProvider.dart';
import 'package:taskit/login_or_Register.dart';
import 'package:taskit/styles/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Taskit';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (context) => NoteProvider())],
      child: MaterialApp(
        routes: {
          '/login': (context) => const Login_or_Register(),
          '/addNote': (context) => const EditNootes(),
        },
        title: _title,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const Login_or_Register(),
      ),
    );
  }
}
