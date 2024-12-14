import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/viewmodels/folders_view_model.dart';
import 'package:first_application/views/folder_widget.dart';

class Folders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoldersViewModel()..loadFolders(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Folders'),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<FoldersViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.folders.isEmpty) {
                    return Center(child: Text('No folders available'));
                  }
                  return ListView.builder(
                    itemCount: viewModel.folders.length,
                    itemBuilder: (context, index) {
                      final folder = viewModel.folders[index];
                      return FolderWidget(title: folder.folderName);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AddFolderWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddFolderWidget extends StatefulWidget {
  @override
  _AddFolderWidgetState createState() => _AddFolderWidgetState();
}

class _AddFolderWidgetState extends State<AddFolderWidget> {
  final TextEditingController _folderNameController = TextEditingController();
  String _selectedColor = 'Blue';
  final List<String> _colors = ['Blue', 'Red', 'Green', 'Yellow'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _folderNameController,
          decoration: InputDecoration(
            labelText: 'Folder Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        DropdownButtonFormField<String>(
          value: _selectedColor,
          items: _colors.map((color) {
            return DropdownMenuItem(
              value: color,
              child: Text(color),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedColor = value!;
            });
          },
          decoration: InputDecoration(
            labelText: 'Folder Color',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            final folderName = _folderNameController.text;
            final folderColor = _selectedColor;
            Provider.of<FoldersViewModel>(context, listen: false)
                .addFolder(folderName, folderColor);
            _folderNameController.clear();
            setState(() {
              _selectedColor = 'Blue';
            });
          },
          child: Text('Add Folder'),
        ),
      ],
    );
  }
}
