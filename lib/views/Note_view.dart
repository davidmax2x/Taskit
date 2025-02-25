import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/Providers/NoteProvider.dart';
import 'package:taskit/Edit%20pages/AddNotePage.dart';
import 'package:taskit/Edit%20pages/EditNotePage.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List notes = context.watch<NoteProvider>().filteredNotes;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNotePage()),
            );
          },
          icon: Icon(LucideIcons.plus,
              color: Theme.of(context).colorScheme.onPrimary),
          label: Text('Add Note',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('My Notes',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: searchTextController,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  decoration: InputDecoration(
                    hintText: 'Search notes...',
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6)),
                    prefixIcon: Icon(LucideIcons.search,
                        color: Theme.of(context).colorScheme.onSurface),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    suffixIcon: searchTextController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(LucideIcons.x,
                                color: Theme.of(context).colorScheme.onSurface),
                            onPressed: () {
                              searchTextController.clear();
                              context
                                  .read<NoteProvider>()
                                  .updateSearchQuery('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  onChanged: (value) {
                    setState(() {}); // Rebuild to show/hide clear button
                    context.read<NoteProvider>().updateSearchQuery(value);
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            notes[index].title[0].toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                        title: Text(
                          notes[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notes[index].courseCode ?? 'No Course Code',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notes[index].lastEdited != null
                                  ? timeago.format(notes[index].lastEdited)
                                  : 'No date',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: Icon(LucideIcons.ellipsisVertical,
                              color: Theme.of(context).colorScheme.onSurface),
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditNotePage(),
                                  settings:
                                      RouteSettings(arguments: notes[index]),
                                ),
                              );
                            } else if (value == 'delete') {
                              context.read<NoteProvider>().deleteNote(index);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: ListTile(
                                leading: Icon(LucideIcons.pencil,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                title: const Text('Edit'),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(LucideIcons.trash,
                                    color: Theme.of(context).colorScheme.error),
                                title: const Text('Delete'),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditNotePage(),
                              settings: RouteSettings(arguments: notes[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                childCount: notes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
