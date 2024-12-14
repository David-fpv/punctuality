import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/viewmodels/add_folder_view_model.dart';

class AddFolderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddFolderViewModel(),
      child: Consumer<AddFolderViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: viewModel.folderNameController,
                  decoration: InputDecoration(
                    labelText: 'Folder Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: viewModel.selectedColor,
                  items: viewModel.colors.map((color) {
                    return DropdownMenuItem(
                      value: color,
                      child: Text(color),
                    );
                  }).toList(),
                  onChanged: (value) {
                    viewModel.setSelectedColor(value!);
                  },
                  decoration: InputDecoration(
                    labelText: 'Folder Color',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          //zprimary: Colors.red, // Цвет кнопки отмены
                          ),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.addFolder(context);
                        Navigator.pop(context);
                      },
                      child: Text('Add Folder'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
