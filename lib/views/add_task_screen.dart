import 'package:first_application/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/viewmodels/add_task_view_model.dart';
import 'package:first_application/themes/task_style.dart';

class AddTask extends StatelessWidget {
  final Task? task;

  const AddTask({Key? key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTaskViewModel(task: task),
      child: Scaffold(
        appBar: AppBar(
          title: Text(task == null ? 'Add Task' : 'Edit Task'),
          backgroundColor: Colors.white,
        ),
        body: Consumer<AddTaskViewModel>(
          builder: (context, viewModel, child) {
            return Padding( 
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: viewModel.titleController,
                    decoration: InputDecoration(labelText: 'Task Title'),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: viewModel.descriptionController,
                    decoration: InputDecoration(labelText: 'Task Description'),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor, // Использование цвета темы
                          borderRadius:
                              BorderRadius.circular(16), // Закругленные края
                        ),
                        child: Center(
                          child: Text(
                            'Категории',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton<String>(
                        value: viewModel.selectedFolder,
                        items: ['None', 'Family', 'Job'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          viewModel.setFolder(newValue!);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor, // Использование цвета темы
                          borderRadius:
                              BorderRadius.circular(16), // Закругленные края
                        ),
                        child: Center(
                          child: Text(
                            'Приоритет',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton<int>(
                        value: viewModel.selectedPriority,
                        items: [0, 1, 2].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value == 0
                                ? 'Low'
                                : value == 1
                                    ? 'Medium'
                                    : 'High'),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          viewModel.setPriority(newValue!);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) viewModel.setDeadline(picked);
                    },
                    child: Text('Select Deadline'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) viewModel.setReminder(picked);
                    },
                    child: Text('Select Reminder'),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor, // Использование цвета темы
                          borderRadius:
                              BorderRadius.circular(16), // Закругленные края
                        ),
                        child: Center(
                          child: Text(
                            'Повтор',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton<String>(
                        value: viewModel.selectedRepeatInterval,
                        items: [
                          'Never',
                          'Раз в день',
                          'Раз в неделю',
                          'Раз в месяц'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          viewModel.setRepeatInterval(newValue!);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'GPS Coordinates'),
                    onChanged: (value) {
                      viewModel.setGpsLocation(value);
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.saveTask();
                    },
                    child: Text('Add Task'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
