import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Components/NoteTextField.dart';
import 'package:taskit/Providers/NoteProvider.dart';

import '../model/Note.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  late TextEditingController titleController;
  late TextEditingController courseController;
  late TextEditingController contentController;
  bool _isEditing = false;
  Note? _originalNote;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    courseController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Note? note = ModalRoute.of(context)?.settings.arguments as Note?;
    debugPrint('Received note: ${note?.title}');
    if (note != null && _originalNote != note) {
      debugPrint('Setting up note for editing');
      _originalNote = note;
      _isEditing = true;
      titleController.text = note.title;
      courseController.text = note.courseCode;
      contentController.text = note.content;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    courseController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(_isEditing ? 'Edit Note' : 'New Note'),
          actions: [
            if (_isEditing)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _showDeleteDialog(context),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () => _saveNote(context),
          child: Icon(_isEditing ? Icons.save : Icons.add),
        ),
        body: Consumer<NoteProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  NoteTextField(
                    controller: titleController,
                    hintText: 'Title',
                  ),
                  const SizedBox(height: 16),
                  NoteTextField(
                    controller: courseController,
                    hintText: 'Course Code',
                  ),
                  const SizedBox(height: 16),
                  _buildContentField(context),
                  if (provider.error != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        provider.error!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContentField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: contentController,
        maxLines: null,
        minLines: 10,
        decoration: const InputDecoration(
          hintText: 'Enter your notes here',
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Future<void> _saveNote(BuildContext context) async {
    if (titleController.text.isEmpty || courseController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final note = Note(
      title: titleController.text,
      courseCode: courseController.text,
      content: contentController.text,
      lastEdited: DateTime.now(),
    );

    try {
      if (_isEditing && _originalNote != null) {
        final index =
            context.read<NoteProvider>().notes.indexOf(_originalNote!);
        await context.read<NoteProvider>().updateNote(note, index);
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
                await context.read<NoteProvider>().removeNote(index);
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
