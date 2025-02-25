import 'package:flutter/material.dart';
import '../models/assignment_model.dart';
import '../services/hive_service.dart';

class AssignmentProvider with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;
  List<Assignment> get pendingAssignments =>
      _assignments.where((assignment) => !assignment.isCompleted).toList();

  Future<void> loadAssignments() async {
    _assignments = await _hiveService.getAllAssignments();
    notifyListeners();
  }

  Future<void> addAssignment(Assignment assignment) async {
    await _hiveService.addAssignment(assignment);
    await loadAssignments();
  }

  Future<void> updateAssignment(int index, Assignment assignment) async {
    await _hiveService.updateAssignment(index, assignment);
    await loadAssignments();
  }

  Future<void> deleteAssignment(int index) async {
    await _hiveService.deleteAssignment(index);
    await loadAssignments();
  }

  Future<void> toggleAssignmentStatus(int index) async {
    final assignment = _assignments[index];
    final updatedAssignment = Assignment(
      title: assignment.title,
      courseCode: assignment.courseCode,
      description: assignment.description,
      dueDate: assignment.dueDate,
      isCompleted: !assignment.isCompleted,
      createdAt: assignment.createdAt,
    );
    await updateAssignment(index, updatedAssignment);
  }

  List<Assignment> getAssignmentsByCourse(String courseCode) {
    return _assignments
        .where((assignment) => assignment.courseCode == courseCode)
        .toList();
  }
}
