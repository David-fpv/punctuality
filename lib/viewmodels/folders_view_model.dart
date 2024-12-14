import 'package:flutter/material.dart';
import 'package:first_application/models/folder_model.dart';
import 'package:first_application/data/database_helper.dart';

class FoldersViewModel extends ChangeNotifier {
  List<Folder> _folders = [];

  List<Folder> get folders => _folders;

  Folder createFolder(String name, String color) {
    return Folder(
      folderId: 1, // SQLite будет автоматически присваивать ID
      folderName: name,
      folderColor: color,
    );
  }

  Future<void> loadFolders() async {
    _folders = await DatabaseHelper.instance.getFolders();
    notifyListeners();
  }

  Future<void> updateTask(Folder folder) async {
    await DatabaseHelper.instance.updateFolder(folder);
    await loadFolders(); // Обновляем список задач после изменения
  }

  Future<void> addFolder(String name, String color) async {
    if (name != '') {
      Folder newFolder = createFolder(name, color);
      await DatabaseHelper.instance.insertFolder(newFolder);
      print('Folder created');
      notifyListeners();
    } else {
      print("Folder didn't create");
    }
  }

  Future<void> deleteTask(Folder folder) async {
    if (folder.folderId == 1)
    {
      print('The first (base) folder cannot be deleted');
      return;
    }
    await DatabaseHelper.instance.deleteFolder(folder.folderId);
    await loadFolders(); // Обновляем список задач после изменения
  }
}