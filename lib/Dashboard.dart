// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:taskit/Components/bottom_nav_bar.dart';
import 'package:taskit/views/Note_view.dart';
import 'package:taskit/views/assignment_view_page.dart';
import 'package:taskit/views/schedule_view.dart';
import 'package:taskit/views/settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> _widgetOptions = <Widget>[
    const NoteView(),
    const AssignmentViewPage(),
    const ScheduleView(),
    const Settings(),
  ];
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_currentIndex],
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar:
          BottomNavBar(currentIndex: _currentIndex, onTabTapped: onTabTapped),
    );
  }
}
