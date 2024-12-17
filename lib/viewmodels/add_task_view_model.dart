import 'package:flutter/material.dart';
import 'package:first_application/models/task_model.dart';
import 'package:first_application/themes/task_style.dart';
import 'package:first_application/data/database_helper.dart';

class AddTaskViewModel extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String selectedTitle = '';
  String selectedDescription = '';
  int selectedFolderId = 0;
  String selectedFolder = 'None';
  int? selectedPriority = 0;
  DateTime? selectedDeadline;
  DateTime? selectedReminder;
  String? selectedRepeatInterval = 'Never';
  String? selectedGpsLocation;
  TaskStyle? selectedTaskStyle = TaskStyle(
    backgroundColor: Colors.white,
    textColor: Colors.black,
    borderColor: Colors.grey,
  );
  int selectedStatus = 0;

  AddTaskViewModel({Task? task}) {
    if (task != null) {
      titleController.text = task.title;
      descriptionController.text = task.description.toString();
      selectedFolderId = task.folderId;
      selectedPriority = task.priority;
      selectedDeadline = task.deadline;
      selectedReminder = task.reminderTime;
      selectedRepeatInterval = task.repeatInterval;
      selectedGpsLocation = task.gpsLocation;
      selectedTaskStyle = TaskStyle(
        backgroundColor: task.taskColor != null
            ? Color(int.parse(task.taskColor!))
            : Colors.white,
        textColor: Colors.black,
        borderColor: Colors.grey,
      );
      selectedStatus = task.status;
    }
  }

  void setFolder(String folder) {
    selectedFolder = folder;
    notifyListeners();
  }

  void setPriority(int priority) {
    selectedPriority = priority;
    notifyListeners();
  }

  void setDeadline(DateTime deadline) {
    selectedDeadline = deadline;
    notifyListeners();
  }

  void setReminder(DateTime reminder) {
    selectedReminder = reminder;
    notifyListeners();
  }

  void setRepeatInterval(String repeatInterval) {
    selectedRepeatInterval = repeatInterval;
    notifyListeners();
  }

  void setGpsLocation(String gpsLocation) {
    selectedGpsLocation = gpsLocation;
    notifyListeners();
  }

  void setTaskStyle(TaskStyle style) {
    selectedTaskStyle = style;
    notifyListeners();
  }

  void setStatus(int status) {
    selectedStatus = status;
    notifyListeners();
  }

  Task createTask() {
    return Task(
      id: 1, // SQLite будет автоматически присваивать ID
      folderId: 1, // Нужно будет установить правильный folderId
      title: titleController.text,
      description: descriptionController.text,
      priority: selectedPriority,
      deadline: selectedDeadline,
      reminderTime: selectedReminder,
      repeatInterval: selectedRepeatInterval,
      gpsLocation: selectedGpsLocation,
      taskColor: selectedTaskStyle?.backgroundColor.toString(),
      status: selectedStatus,
    );
  }

  Future<void> saveTask() async {
    if (titleController.text.isNotEmpty && selectedFolder.isNotEmpty) {
      Task newTask = createTask();
      await DatabaseHelper.database_punctuality.insertTask(newTask);
      print('Task created');
      notifyListeners();
    } else {
      print("Task didn't create");
    }
  }

  Future<void> updateTask(Task task) async {
    if (titleController.text.isNotEmpty && selectedFolder.isNotEmpty) {
      await DatabaseHelper.database_punctuality.updateTask(task);
      print('Task updated');
      notifyListeners();
    } else {
      print("Task didn't update");
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
