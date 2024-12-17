import 'package:first_application/views/tasks_folder_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_application/viewmodels/folders_view_model.dart';

class Folders extends StatefulWidget {
  @override
  _FoldersState createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  bool _isPanelVisible = false;

  void _togglePanel() {
    setState(() {
      _isPanelVisible = !_isPanelVisible;
    });
  }

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
                      return Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 350,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TasksFolderScreen(folder: folder),
                                  ),
                                );
                              },
                              onLongPress: () {
                                viewModel.deleteFolder(folder);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16), // Закругленные края
                                ),
                              ),
                              child: Text(
                                folder.folderName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _isPanelVisible ? 250.0 : 0.0,
              child: Visibility(
                visible: _isPanelVisible,
                child: AddFolderWidget(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _togglePanel,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            _isPanelVisible ? Icons.close : Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
          SizedBox(
            height: 50,
            width: 200,
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
