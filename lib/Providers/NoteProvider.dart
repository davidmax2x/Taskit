import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/hive_service.dart';

class NoteProvider with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  List<Note> _notes = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Note> get notes => _notes;

  List<Note> get filteredNotes {
    if (_searchQuery.trim().isEmpty) return _notes;
    return _notes.where((note) {
      final query = _searchQuery.toLowerCase();
      return note.title.toLowerCase().contains(query) ||
          note.courseCode.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);
    }).toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Load notes from Hive
  Future<void> loadNotes() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      _notes = await _hiveService.getAllNotes();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add note
  Future<void> addNote(Note note) async {
    await _hiveService.addNote(note);
    await loadNotes();
  }

  // Update note
  Future<void> updateNote(int index, Note note) async {
    await _hiveService.updateNote(index, note);
    await loadNotes();
  }

  // Delete note
  Future<void> deleteNote(int index) async {
    await _hiveService.deleteNote(index);
    await loadNotes();
  }

  // Get notes by course code
  List<Note> getNotesByCourse(String courseCode) {
    return _notes.where((note) => note.courseCode == courseCode).toList();
  }
}
