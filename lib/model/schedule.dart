import 'package:flutter/material.dart';

class Schedule {
  final String id; // Unique identifier
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay? time;
  final String status;
  final bool reminder;

  Schedule({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.time,
    required this.status,
    required this.reminder,
  });
}
