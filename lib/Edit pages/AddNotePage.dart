import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Providers/NoteProvider.dart';
import '../models/note_model.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController titleController;
  late TextEditingController courseController;
  late TextEditingController noteController;
  bool _isTitleValid = true;
  bool _isCourseCodeValid = true;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    courseController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    courseController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text('Add Note'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () => _saveNote(context),
          child: const Icon(Icons.save),
        ),
        body: Consumer<NoteProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    context,
                    controller: titleController,
                    hintText: 'Title',
                    icon: Icons.title,
                    isValid: _isTitleValid,
                    errorText: 'Title cannot be empty',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    controller: courseController,
                    hintText: 'Course Code',
                    icon: Icons.code,
                    isValid: _isCourseCodeValid,
                    errorText: 'Course Code cannot be empty',
                  ),
                  const SizedBox(height: 16),
                  _buildNoteField(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context,
      {required TextEditingController controller,
      required String hintText,
      required IconData icon,
      required bool isValid,
      required String errorText}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon:
              Icon(icon, color: Theme.of(context).colorScheme.secondary),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          errorText: isValid ? null : errorText,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onChanged: (value) {
          setState(() {
            if (controller == titleController) {
              _isTitleValid = value.isNotEmpty;
            } else if (controller == courseController) {
              _isCourseCodeValid = value.isNotEmpty;
            }
          });
        },
      ),
    );
  }

  Widget _buildNoteField(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: noteController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Note',
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  Future<void> _saveNote(BuildContext context) async {
    setState(() {
      _isTitleValid = titleController.text.isNotEmpty;
      _isCourseCodeValid = courseController.text.isNotEmpty;
    });

    if (!_isTitleValid || !_isCourseCodeValid) {
      return;
    }

    final note = Note(
      title: titleController.text,
      courseCode: courseController.text,
      content: noteController.text,
      createdAt: DateTime.now(),
      lastEdited: DateTime.now(),
    );
    try {
      await context.read<NoteProvider>().addNote(note);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }
}
