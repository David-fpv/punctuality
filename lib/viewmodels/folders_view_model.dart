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
    _folders = await DatabaseHelper.database_punctuality.getFolders();
    notifyListeners();
  }

  Future<void> updateFolder(Folder folder) async {
    await DatabaseHelper.database_punctuality.updateFolder(folder);
    await loadFolders(); // Обновляем список задач после изменения
  }

  Future<void> addFolder(String name, String color) async {
    if (name != '') {
      Folder newFolder = createFolder(name, color);
      await DatabaseHelper.database_punctuality.insertFolder(newFolder);
      print('Folder created');
      await loadFolders(); // Обновляем список папок после добавления
    } else {
      print("Folder didn't create");
    }
  }

  Future<void> deleteFolder(Folder folder) async {
    if (folder.folderId == 1) {
      print('The first (base) folder cannot be deleted');
      return;
    }
    await DatabaseHelper.database_punctuality.deleteFolder(folder.folderId);
    await loadFolders(); // Обновляем список задач после изменения
  }
}
