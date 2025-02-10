import 'package:flutter/material.dart';
import 'package:taskit/model/Note.dart';

class EditNote extends StatelessWidget {
  const EditNote({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    final Note? note = ModalRoute.of(context)?.settings.arguments as Note?;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.edit),
          onPressed: () {
            // context.read<NoteProvider>().updateNote(, )
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
