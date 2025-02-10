import 'package:flutter/material.dart';
import '../model/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  final List<Schedule> schedules = [];
  String _searchQuery = '';

  void addSchedule(Schedule schedule) {
    schedules.add(schedule);
    notifyListeners();
  }

  void updateSchedule(int index, Schedule schedule) {
    schedules[index] = schedule;
    notifyListeners();
  }

  void removeSchedule(int index) {
    schedules.removeAt(index);
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  String get searchQuery => _searchQuery;
}
