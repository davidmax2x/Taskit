import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
      bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          containerHeight: 60,
          curve: Curves.easeIn,
          itemCornerRadius: 10,
          iconSize: 25,
          onItemSelected: onTabTapped,
          items: [
            BottomNavyBarItem(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              icon: const Icon(LucideIcons.notepadText),
              title: const Text(
                'Notes',
              ),
              textAlign: TextAlign.right,
            ),
            BottomNavyBarItem(
              textAlign: TextAlign.right,
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              icon: const Icon(LucideIcons.bookA),
              title: const Text(
                'Assignment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BottomNavyBarItem(
              icon: const Icon(LucideIcons.calendar1),
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              title: const Text(
                'Schedule',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(LucideIcons.settings),
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
