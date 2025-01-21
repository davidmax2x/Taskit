import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final TextEditingController searchTextController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showTitleDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimSearchBar(
                width: MediaQuery.of(context).size.width,
                helpText: 'Search Notes',
                closeSearchOnSuffixTap: true,
                textController: searchTextController,
                onSubmitted: (value) {
                  print(value);
                },
                onSuffixTap: () {
                  setState(() {
                    searchTextController.clear();
                  });
                },
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'NoteView is working',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Note Title'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Note Title'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/addNote',
                    arguments: titleController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
