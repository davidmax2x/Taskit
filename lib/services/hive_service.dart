import 'package:hive_flutter/hive_flutter.dart';
import '../models/note_model.dart';
import '../models/schedule_model.dart';
import '../models/assignment_model.dart';

class HiveService {
  static const String notesBoxName = 'notes';
  static const String schedulesBoxName = 'schedules';
  static const String assignmentsBoxName = 'assignments';

  // Boxes
  Future<Box<Note>> get notesBox async =>
      await Hive.openBox<Note>(notesBoxName);
  Future<Box<Schedule>> get schedulesBox async =>
      await Hive.openBox<Schedule>(schedulesBoxName);
  Future<Box<Assignment>> get assignmentsBox async =>
      await Hive.openBox<Assignment>(assignmentsBoxName);

  // Note operations
  Future<void> addNote(Note note) async {
    final box = await notesBox;
    await box.add(note);
  }

  Future<List<Note>> getAllNotes() async {
    final box = await notesBox;
    return box.values.toList();
  }

  Future<void> updateNote(int index, Note note) async {
    final box = await notesBox;
    await box.putAt(index, note);
  }

  Future<void> deleteNote(int index) async {
    final box = await notesBox;
    await box.deleteAt(index);
  }

  // Schedule operations
  Future<void> addSchedule(Schedule schedule) async {
    final box = await schedulesBox;
    await box.add(schedule);
  }

  Future<List<Schedule>> getAllSchedules() async {
    final box = await schedulesBox;
    return box.values.toList();
  }

  Future<void> updateSchedule(int index, Schedule schedule) async {
    final box = await schedulesBox;
    await box.putAt(index, schedule);
  }

  Future<void> deleteSchedule(int index) async {
    final box = await schedulesBox;
    await box.deleteAt(index);
  }

  // Assignment operations
  Future<void> addAssignment(Assignment assignment) async {
    final box = await assignmentsBox;
    await box.add(assignment);
  }

  Future<List<Assignment>> getAllAssignments() async {
    final box = await assignmentsBox;
    return box.values.toList();
  }

  Future<void> updateAssignment(int index, Assignment assignment) async {
    final box = await assignmentsBox;
    await box.putAt(index, assignment);
  }

  Future<void> deleteAssignment(int index) async {
    final box = await assignmentsBox;
    await box.deleteAt(index);
  }

  // Clear operations
  Future<void> clearAll() async {
    final notesB = await notesBox;
    final schedulesB = await schedulesBox;
    final assignmentsB = await assignmentsBox;

    await notesB.clear();
    await schedulesB.clear();
    await assignmentsB.clear();
  }
}
