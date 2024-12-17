import 'package:flutter/material.dart';
import 'package:first_application/models/folder_model.dart';
import 'package:first_application/models/task_model.dart';
import 'package:first_application/data/database_helper.dart';

class TasksFolderViewModel extends ChangeNotifier {
  final Folder folder;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TasksFolderViewModel({required this.folder}) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _tasks = await DatabaseHelper.database_punctuality.getTasksByFolderName(folder.folderName);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.database_punctuality.updateTask(task);
    await loadTasks(); // Обновляем список задач после изменения
  }

  Future<void> deleteTask(Task task) async {
    await DatabaseHelper.database_punctuality.deleteTask(task.id);
    await loadTasks(); // Обновляем список задач после изменения
  }
}