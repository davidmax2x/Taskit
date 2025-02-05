import 'package:flutter/material.dart';
import 'package:taskit/model/Note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = [];

  void addnotes(Note newNote) {
    notes.add(newNote);
    notifyListeners();
  }

  void removeNotes(int index) {
    notes.removeAt(index);
    notifyListeners();
  }

  void updateNote(Note updatedNote, int index) {
    notes[index] = updatedNote;
    notifyListeners();
  }
}
