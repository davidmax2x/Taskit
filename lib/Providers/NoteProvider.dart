import 'package:flutter/material.dart';
import 'package:taskit/model/Note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = [];

  void addnotes(Note newNote) {
    notes.add(newNote);
    notifyListeners();
  }
}
