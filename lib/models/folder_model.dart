class Folder {
  final int folderId;
  String folderName;
  String folderColor;

  Folder({
    required this.folderId,
    required this.folderName,
    required this.folderColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'folder_name': folderName,
      'folder_color': folderColor,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      folderId: map['folder_id'],
      folderName: map['folder_name'],
      folderColor: map['folder_color'],
    );
  }
}