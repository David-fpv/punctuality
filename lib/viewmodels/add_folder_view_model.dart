import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/models/folder_model.dart';
import 'package:first_application/viewmodels/folders_view_model.dart';
import 'package:first_application/data/database_helper.dart';

class AddFolderViewModel extends ChangeNotifier {
  final TextEditingController folderNameController = TextEditingController();
  String selectedColor = 'Blue';
  final List<String> colors = ['Blue', 'Red', 'Green', 'Yellow'];

  void setSelectedColor(String color) {
    selectedColor = color;
    notifyListeners();
  }

  Future<void> addFolder(BuildContext context) async {
    print('Try to add new folder ${folderNameController.text}, ${selectedColor}');
    Folder newFolder = Folder(folderId: 1, folderName: folderNameController.text, folderColor: selectedColor);
    await DatabaseHelper.instance.insertFolder(newFolder);
    folderNameController.clear();
    selectedColor = 'Blue';
    notifyListeners();
  }
  
}
