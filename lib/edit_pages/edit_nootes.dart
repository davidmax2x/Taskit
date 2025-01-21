import 'package:flutter/material.dart';

class EditNotesPage extends StatefulWidget {
  @override
  _EditNotesPageState createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _noteController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Enter your note here...',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Save the note
            print('Note saved: ${_noteController.text}');
            Navigator.pop(context);
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
