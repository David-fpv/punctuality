import 'package:first_application/themes/task_style.dart';

class Task {
  final int id;
  final int folderId;
  final String title;
  final String? description;
  final int? priority;
  final DateTime? deadline;
  final DateTime? reminderTime;
  final String? repeatInterval;
  final String? gpsLocation;
  final String? taskColor;
  int status;

  Task({
    required this.id,
    required this.folderId,
    required this.title,
    this.description,
    this.priority,
    this.deadline,
    this.reminderTime,
    this.repeatInterval,
    this.gpsLocation,
    this.taskColor,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'folder_id': folderId,
      'title': title,
      'description': description,
      'priority': priority,
      'deadline': deadline?.toIso8601String(),
      'reminder_time': reminderTime?.toIso8601String(),
      'repeat_interval': repeatInterval,
      'gps_location': gpsLocation,
      'task_color': taskColor,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['task_id'],
      folderId: map['folder_id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      reminderTime: map['reminder_time'] != null ? DateTime.parse(map['reminder_time']) : null,
      repeatInterval: map['repeat_interval'],
      gpsLocation: map['gps_location'],
      taskColor: map['task_color'],
      status: map['status'] != null ? map['status'] : 1,
    );
  }
}