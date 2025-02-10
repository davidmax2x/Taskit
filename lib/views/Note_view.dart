import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Components/noteListTile.dart';

import 'package:taskit/Providers/NoteProvider.dart';

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
    List notes = context.watch<NoteProvider>().filteredNotes;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            Navigator.pushNamed(context, '/addNote');
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: searchTextController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  hintText: 'Search notes...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  suffixIcon: searchTextController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchTextController.clear();
                            context.read<NoteProvider>().updateSearchQuery('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Rebuild to show/hide clear button
                  context.read<NoteProvider>().updateSearchQuery(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              context.read<NoteProvider>().removeNote(index);
                            },
                            borderRadius: BorderRadius.circular(5),
                            icon: Icons.delete,
                            spacing: 0,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            debugPrint('Note tapped: ${notes[index].title}');
                            Navigator.pushNamed(
                              context,
                              '/addNote',
                              arguments: notes[index],
                            );
                          });
                        },
                        child: NoteListTile(
                            title: notes[index].title,
                            courseCode: notes[index].courseCode,
                            time: DateTime.now().toLocal()),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
