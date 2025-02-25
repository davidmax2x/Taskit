import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Edit%20pages/AddNotePage.dart';
import 'package:taskit/Providers/NoteProvider.dart';
import 'package:taskit/Providers/ScheduleProvider.dart';
import 'package:taskit/login_or_Register.dart';
import 'package:taskit/styles/theme.dart';
import 'package:taskit/Providers/AssignmentProvider.dart';
import 'views/assignment_view_page.dart';

import 'Edit pages/EditNotePage.dart';
import 'services/notification_service.dart';
import 'screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskit/models/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  // Register Hive Adapters
  Hive.registerAdapter(NoteAdapter()); // Assuming NoteAdapter is defined in note_model.dart

  // Open Hive boxes
  await Hive.openBox<Note>('notes');

  // Initialize notifications
  await NotificationService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (context) => AssignmentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Taskit';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const Login_or_Register(),
        '/addNote': (context) => const AddNotePage(),
        '/editNote': (context) => const EditNotePage(),
        '/assignments': (context) => const AssignmentViewPage(),
      },
      title: _title,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(),
    );
  }
}
