import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:taskit/Providers/NoteProvider.dart';

import '../models/note_model.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleController;
  late TextEditingController courseController;
  late TextEditingController noteController;
  Note? _originalNote;
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Note? note = ModalRoute.of(context)?.settings.arguments as Note?;
    if (note != null && _originalNote != note) {
      _originalNote = note;
      titleController.text = note.title;
      courseController.text = note.courseCode;
      noteController.text = note.content;
    }
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
          title: const Text('Edit Note'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showDeleteDialog(context),
            ),
          ],
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
      createdAt: _originalNote?.createdAt ?? DateTime.now(),
      lastEdited: DateTime.now(),
    );

    try {
      if (_originalNote != null) {
        final index =
            context.read<NoteProvider>().notes.indexOf(_originalNote!);
        await context.read<NoteProvider>().updateNote(index, note);
      } else {
        await context.read<NoteProvider>().addNote(note);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_originalNote != null) {
                final index =
                    context.read<NoteProvider>().notes.indexOf(_originalNote!);
                await context.read<NoteProvider>().deleteNote(index);
                if (mounted) {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Return to notes list
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
