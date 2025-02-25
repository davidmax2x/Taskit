import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/assignment_model.dart';
import '../Providers/AssignmentProvider.dart';

class AddAssignmentPage extends StatefulWidget {
  const AddAssignmentPage({super.key});

  @override
  State<AddAssignmentPage> createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  final _courseNameController = TextEditingController();
  final _assignmentTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _submissionMethodController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _dueDate = DateTime.now();
  TimeOfDay _dueTime = TimeOfDay.now();
  String _priority = 'Medium';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Assignment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Course Name', _courseNameController, true),
              _buildTextField(
                  'Assignment Title', _assignmentTitleController, true),
              _buildTextField('Description', _descriptionController, false),
              _buildTextField(
                  'Submission Method', _submissionMethodController, false),
              _buildTextField('Notes', _notesController, false),
              _buildDueDatePicker(context),
              _buildDueTimePicker(context),
              _buildPriorityDropdown(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addAssignment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Add Assignment',
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildDueDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: const Text('Due Date'),
        subtitle: Text('${_dueDate.toLocal()}'.split(' ')[0]),
        trailing: const Icon(Icons.calendar_today),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: _dueDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2101),
          );
          if (picked != null && picked != _dueDate) {
            setState(() {
              _dueDate = picked;
            });
          }
        },
      ),
    );
  }

  Widget _buildDueTimePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: const Text('Due Time'),
        subtitle: Text(_dueTime.format(context)),
        trailing: const Icon(Icons.access_time),
        onTap: () async {
          TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: _dueTime,
          );
          if (picked != null && picked != _dueTime) {
            setState(() {
              _dueTime = picked;
            });
          }
        },
      ),
    );
  }

  Widget _buildPriorityDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _priority,
        items: ['High', 'Medium', 'Low'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _priority = newValue!;
          });
        },
        decoration: InputDecoration(
          labelText: 'Priority',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  void _addAssignment() {
    if (_formKey.currentState?.validate() ?? false) {
      final newAssignment = Assignment(
        title: _assignmentTitleController.text,
        courseCode: _courseNameController.text,
        description: _descriptionController.text,
        dueDate: DateTime(
          _dueDate.year,
          _dueDate.month,
          _dueDate.day,
          _dueTime.hour,
          _dueTime.minute,
        ),
        createdAt: DateTime.now(),
        submissionMethod: _submissionMethodController.text,
        assignmentNotes: _notesController.text,
        priority: _priority,
      );

      Provider.of<AssignmentProvider>(context, listen: false)
          .addAssignment(newAssignment);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assignment added successfully')),
      );
      Navigator.pop(context);
    }
  }
}
