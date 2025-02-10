import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Providers/schedule_provider.dart';
import 'package:taskit/model/schedule.dart';

class EditSchedule extends StatefulWidget {
  final Schedule? scheduleToEdit;
  final int? scheduleIndex;

  const EditSchedule({
    super.key,
    this.scheduleToEdit,
    this.scheduleIndex,
  });

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String status = 'Pending';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: _saveSchedule,
          child: const Icon(Icons.save),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextField(titleController: titleController),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: const OutlineInputBorder(),
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Date'),
                subtitle: Text(selectedDate != null
                    ? selectedDate.toString()
                    : 'Select a date'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: status,
                items: ['Pending', 'Completed']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _saveSchedule() {
    // Implement save functionality
    setState(() {
      context.read<ScheduleProvider>().addSchedule(Schedule(
          title: titleController.text,
          description: descriptionController.text,
          date: selectedDate!,
          status: status));
    });
    Navigator.pop(context);
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      decoration: InputDecoration(
        labelText: 'Title',
        border: const OutlineInputBorder(),
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
      ),
    );
  }
}
