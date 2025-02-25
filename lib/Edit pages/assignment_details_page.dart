import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/AssignmentProvider.dart';
import 'package:intl/intl.dart';

class AssignmentDetailsPage extends StatelessWidget {
  final String courseName;
  final String assignmentTitle;
  final String description;
  final String submissionMethod;
  final String notes;
  final DateTime dueDate;
  final String priority;
  final int index;

  const AssignmentDetailsPage({
    super.key,
    required this.courseName,
    required this.assignmentTitle,
    required this.description,
    required this.submissionMethod,
    required this.notes,
    required this.dueDate,
    required this.priority,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName: $assignmentTitle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteAssignment(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailSection('Description', description),
            _buildDetailSection('Submission Method', submissionMethod),
            _buildDetailSection('Notes', notes),
            _buildDetailSection(
                'Due Date', DateFormat('yyyy-MM-dd – kk:mm').format(dueDate)),
            _buildDetailSection('Priority', priority),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteAssignment(BuildContext context) {
    Provider.of<AssignmentProvider>(context, listen: false)
        .deleteAssignment(index);
    Navigator.pop(context);
  }
}
