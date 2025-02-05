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

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    courseController = TextEditingController();
    contentController = TextEditingController();
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
    final Note? note = ModalRoute.of(context)!.settings.arguments as Note?;
    debugPrint('Received note: ${note?.title}');

    if (note != null) {
      titleController.text = note.title;
      courseController.text = note.courseCode;
      contentController.text = note.content;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            Note newNote = Note(
              title: titleController.text,
              courseCode: courseController.text,
              content: contentController.text,
              lastEdited: DateTime.now(),
            );
            setState(() {
              if (note != null) {
                context.read<NoteProvider>().updateNote(
                  newNote,
                  context.read<NoteProvider>().notes.indexOf(note),
                );
              } else {
                context.read<NoteProvider>().addnotes(newNote);
              }
              Navigator.of(context).pop();
            });
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(),
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                NoteTextField(
                  controller: titleController,
                  hintText: 'Title',
                ),
                const SizedBox(height: 10),
                NoteTextField(
                  controller: courseController,
                  hintText: 'Course Code',
                ),
                const SizedBox(height: 5),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Course Code History',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: contentController,
                    maxLines: null,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Enter your notes here',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}