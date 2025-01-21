import 'package:flutter/material.dart';
import 'package:taskit/edit_pages/Edit_nootes.dart';
import 'package:taskit/login_or_Register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const Login_or_Register(),
        '/addNote':(context)=>  EditNotesPage(),
      },
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const Login_or_Register(),
    );
  }
}
