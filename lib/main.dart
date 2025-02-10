import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Providers/NoteProvider.dart';
import 'package:taskit/Providers/schedule_provider.dart';
import 'package:taskit/login_or_Register.dart';
import 'package:taskit/styles/theme.dart';

import 'Edit pages/AddNote.dart';
import 'Edit pages/EditNote.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NoteProvider()),
          ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Taskit';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const Login_or_Register(),
        '/addNote': (context) => const Addnote(),
        '/editNote': (context) => const EditNote(),
      },
      title: _title,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Login_or_Register(),
    );
  }
}
