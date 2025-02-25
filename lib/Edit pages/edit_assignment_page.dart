import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/assignment_model.dart';
import '../Providers/AssignmentProvider.dart';
import 'package:intl/intl.dart';

class EditAssignmentPage extends StatefulWidget {
  final int index;
  final Assignment assignment;

  const EditAssignmentPage({
    super.key,
    required this.index,
    required this.assignment,
  });

  @override
  State<EditAssignmentPage> createState() => _EditAssignmentPageState();
}

class _EditAssignmentPageState extends State<EditAssignmentPage> {
  late TextEditingController _courseNameController;
  late TextEditingController _assignmentTitleController;
  late TextEditingController _descriptionController;
  late TextEditingController _submissionMethodController;
  late TextEditingController _notesController;
  late DateTime _dueDate;
  late TimeOfDay _dueTime;
  late String _priority;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _courseNameController =
        TextEditingController(text: widget.assignment.courseCode);
    _assignmentTitleController =
        TextEditingController(text: widget.assignment.title);
    _descriptionController =
        TextEditingController(text: widget.assignment.description);
    _submissionMethodController = TextEditingController(
        text: widget.assignment.submissionMethod);
    _notesController =
        TextEditingController(text: widget.assignment.assignmentNotes);
    _dueDate = widget.assignment.dueDate;
    _dueTime = TimeOfDay.fromDateTime(widget.assignment.dueDate);
    _priority = widget.assignment.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Assignment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildDetailSection('Course Name', _courseNameController, true),
              _buildDetailSection(
                  'Assignment Title', _assignmentTitleController, true),
              _buildDetailSection('Description', _descriptionController, false),
              _buildDetailSection(
                  'Submission Method', _submissionMethodController, false),
              _buildDetailSection('Notes', _notesController, false),
              _buildDueDatePicker(context),
              _buildDueTimePicker(context),
              _buildPriorityDropdown(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _editAssignment,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary),
                child: Text('Save Changes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(
      String label, TextEditingController controller, bool isRequired) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
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
      ),
    );
  }

  Widget _buildDueDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: const Text('Due Date'),
          subtitle: Text(DateFormat('yyyy-MM-dd').format(_dueDate).toString()),
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
      ),
    );
  }

  Widget _buildDueTimePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10)),
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  void _editAssignment() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedAssignment = Assignment(
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
        createdAt: widget.assignment?.createdAt ?? DateTime.now(),
        isCompleted: false,
      );

      Provider.of<AssignmentProvider>(context, listen: false)
          .updateAssignment(widget.index, updatedAssignment);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assignment updated successfully')),
      );
      Navigator.pop(context);
    }
  }
}
