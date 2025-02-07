import 'package:flutter/material.dart';
import '../models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  final List<Schedule> _schedules = [];

  List<Schedule> get schedules => List.unmodifiable(_schedules);

  void addSchedule(Schedule schedule) {
    _schedules.add(schedule);
    notifyListeners();
  }

  void updateSchedule(int index, Schedule schedule) {
    _schedules[index] = schedule;
    notifyListeners();
  }

  void removeSchedule(int index) {
    _schedules.removeAt(index);
    notifyListeners();
  }
}
