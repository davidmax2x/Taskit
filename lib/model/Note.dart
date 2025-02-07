class Note {
  final String title;
  final String courseCode;
  final String content;
  final DateTime lastEdited;

  Note({
    required this.title,
    required this.courseCode,
    required this.content,
    required this.lastEdited,
  });

  bool get isValid => title.isNotEmpty && courseCode.isNotEmpty;
}
