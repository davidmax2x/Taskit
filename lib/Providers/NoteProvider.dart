import 'package:flutter/material.dart';
import 'package:taskit/model/Note.dart';

class NoteProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  final List<Note> _notes = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Note> get notes => _notes;

  List<Note> get filteredNotes {
    if (_searchQuery.isEmpty) return _notes;
    return _notes.where((note) {
      return note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.courseCode.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.content.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _notes.add(note);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeNote(int index) async {
    _notes.removeAt(index);
    notifyListeners();
  }

  Future<void> updateNote(Note note, int index) async {
    _notes[index] = note;
    notifyListeners();
  }
}
