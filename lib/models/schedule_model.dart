import 'package:hive/hive.dart';

part 'schedule_model.g.dart';

@HiveType(typeId: 2)
class Schedule extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String day;

  @HiveField(4)
  String time;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  String status;

  @HiveField(7)
  bool reminder;

  @HiveField(8)
  int? notificationId;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.day,
    required this.time,
    required this.date,
    this.status = 'Pending',
    this.reminder = false,
    this.notificationId,
  });
}
