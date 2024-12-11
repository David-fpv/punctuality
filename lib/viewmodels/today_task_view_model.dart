import 'package:flutter/material.dart';
import 'package:first_application/models/task_model.dart';
import 'package:first_application/data/database_helper.dart';

class TodayTaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await DatabaseHelper.instance.getTasks();
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await loadTasks(); // Обновляем список задач после изменения
  }

  Future<void> deleteTask(Task task) async {
    await DatabaseHelper.instance.deleteTask(task.id);
    await loadTasks(); // Обновляем список задач после изменения
  }
}