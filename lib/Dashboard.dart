import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavyBar(
          showElevation: false,
          itemPadding: const EdgeInsets.symmetric(horizontal: 10),
          itemCornerRadius: 24,
          iconSize: 20,
          onItemSelected: (index) {},
          items: [
            BottomNavyBarItem(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              icon: const Icon(LucideIcons.notepadText),
              title: const Text(
                'Notes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              icon: const Icon(LucideIcons.bookA),
              title: const Text(
                'Assignment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
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
