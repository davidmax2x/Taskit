import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  String courseCode;

  @HiveField(4)
  DateTime lastEdited;

  Note({
    required this.title,
    required this.courseCode,
    required this.content,
    required this.createdAt,
    required this.lastEdited,
  });
}
