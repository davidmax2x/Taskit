import 'package:flutter/material.dart';
import '../models/schedule_model.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';

class ScheduleProvider with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  final NotificationService _notificationService = NotificationService();
  List<Schedule> _schedules = [];
  String _searchQuery = '';

  List<Schedule> get schedules => _schedules;

  Future<void> loadSchedules() async {
    _schedules = await _hiveService.getAllSchedules();
    notifyListeners();
  }

  Future<void> addSchedule(Schedule schedule) async {
    await _hiveService.addSchedule(schedule);
    if (schedule.reminder) {
      await _notificationService.scheduleNotification(schedule);
    }
    await loadSchedules();
  }

  Future<void> updateSchedule(int index, Schedule schedule) async {
    final oldSchedule = _schedules[index];
    if (oldSchedule.notificationId != null) {
      await _notificationService
          .cancelNotification(oldSchedule.notificationId!);
    }

    await _hiveService.updateSchedule(index, schedule);
    if (schedule.reminder) {
      await _notificationService.scheduleNotification(schedule);
    }
    await loadSchedules();
  }

  Future<void> deleteSchedule(int index) async {
    final schedule = _schedules[index];
    if (schedule.notificationId != null) {
      await _notificationService.cancelNotification(schedule.notificationId!);
    }
    await _hiveService.deleteSchedule(index);
    await loadSchedules();
  }

  List<Schedule> getSchedulesByCourse(String courseTitle) {
    return _schedules
        .where((schedule) => schedule.title == courseTitle)
        .toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  String get searchQuery => _searchQuery;
}
