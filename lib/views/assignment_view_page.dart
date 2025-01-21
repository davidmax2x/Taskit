import 'package:flutter/material.dart';

class AssignmentViewPage extends StatefulWidget {
  const AssignmentViewPage({super.key});

  @override
  State<AssignmentViewPage> createState() => _AssignmentViewPageState();
}

class _AssignmentViewPageState extends State<AssignmentViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'AssignmentViewPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
