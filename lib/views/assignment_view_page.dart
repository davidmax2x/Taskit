import 'package:flutter/material.dart';

class AssignmentViewPage extends StatefulWidget {
  const AssignmentViewPage({super.key});

  @override
  State<AssignmentViewPage> createState() => _AssignmentViewPageState();
}

class _AssignmentViewPageState extends State<AssignmentViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(
        child: Text(
          'AssignmentViewPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
