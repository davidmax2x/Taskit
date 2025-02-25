class Note {
  final String title;
  final String courseCode;
  final String content;
  final DateTime lastEdited;
  final DateTime createdAt;

  Note({
    required this.title,
    required this.courseCode,
    required this.content,
    required this.lastEdited,
    required this.createdAt,
  });

  bool get isValid => title.isNotEmpty && courseCode.isNotEmpty;
}
