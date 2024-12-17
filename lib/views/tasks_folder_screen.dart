import 'package:first_application/views/add_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/models/folder_model.dart';
import 'package:first_application/viewmodels/tasks_folder_view_model.dart';

class TasksFolderScreen extends StatelessWidget {
  final Folder folder;

  const TasksFolderScreen({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksFolderViewModel(folder: folder)..loadTasks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(folder.folderName),
          backgroundColor: Colors.white,
        ),
        body: Consumer<TasksFolderViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.tasks.isEmpty) {
              return Center(child: Text('No tasks available'));
            }
            return ListView.builder(
              itemCount: viewModel.tasks.length,
              itemBuilder: (context, index) {
                final task = viewModel.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTask(task: task),
                      ),
                    );
                  },
                  onLongPress: () {
                    viewModel.deleteTask(task);
                  },
                  trailing: Checkbox(
                    value: task.status == 1,
                    onChanged: (bool? value) {
                      // Обновление статуса задачи
                      task.status = value! ? 1 : 0;
                      viewModel.updateTask(task);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
