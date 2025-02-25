import 'package:hive/hive.dart';

part 'assignment_model.g.dart';

@HiveType(typeId: 3)
class Assignment extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String courseCode;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  String submissionMethod;

  @HiveField(7)
  String assignmentNotes;

  @HiveField(8)
  String priority;

  Assignment({
    required this.title,
    required this.courseCode,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.createdAt,
    this.submissionMethod = '',
    this.assignmentNotes = '',
    this.priority = 'Medium',
  });

  factory Assignment.fromAssignment(Assignment other) {
    return Assignment(
      title: other.title,
      courseCode: other.courseCode,
      description: other.description,
      dueDate: other.dueDate,
      createdAt: other.createdAt,
      isCompleted: other.isCompleted,
      submissionMethod: other.submissionMethod,
      assignmentNotes: other.assignmentNotes,
      priority: other.priority,
    );
  }
}
