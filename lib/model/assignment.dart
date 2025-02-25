class Assignment {
  final String id;
  final String courseName;
  final String assignmentTitle;
  final String assignmentDescription;
  final String assignmentSubmissionMethod;
  final String assignmentNotes;
  final DateTime dueDate;
  final String priority;
  bool isCompleted;

  Assignment({
    required this.id,
    required this.courseName,
    required this.assignmentTitle,
    required this.assignmentDescription,
    required this.assignmentSubmissionMethod,
    required this.assignmentNotes,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}
