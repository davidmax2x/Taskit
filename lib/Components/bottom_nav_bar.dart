import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTabTapped});
  final int currentIndex;
  final Function(int) onTabTapped;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        selectedIndex: widget.currentIndex,
        containerHeight: 60,
        curve: Curves.ease,
        animationDuration: const Duration(milliseconds: 500),
        itemCornerRadius: 15,
        iconSize: 25,
        onItemSelected: widget.onTabTapped,
        items: [
          BottomNavyBarItem(
            activeColor: Theme.of(context).colorScheme.secondary,
            inactiveColor: Theme.of(context).colorScheme.secondary,
            icon: const Icon(LucideIcons.notepadText),
            title: const Text(
              'Notes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavyBarItem(
            activeColor: Theme.of(context).colorScheme.secondary,
            inactiveColor: Theme.of(context).colorScheme.secondary,
            icon: const Icon(LucideIcons.bookA),
            title: const Text(
              'Class Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavyBarItem(
            icon: const Icon(LucideIcons.calendar1),
            activeColor: Theme.of(context).colorScheme.secondary,
            inactiveColor: Theme.of(context).colorScheme.secondary,
            title: const Text(
              'Schedule',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavyBarItem(
            icon: const Icon(LucideIcons.settings),
            activeColor: Theme.of(context).colorScheme.secondary,
            inactiveColor: Theme.of(context).colorScheme.secondary,
            title: const Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]);
  }
}
