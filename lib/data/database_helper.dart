import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:first_application/models/task_model.dart';
import 'package:first_application/models/profile_model.dart';
import 'package:first_application/models/folder_model.dart';

class DatabaseHelper {
  static final DatabaseHelper database_punctuality = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo_test4.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS users (
      user_id INTEGER NOT NULL UNIQUE,
      username TEXT,
      email TEXT,
      rating INTEGER NOT NULL DEFAULT 0,
      succesful_tasks INTEGER NOT NULL DEFAULT 0,
      average_tasks_per_day INTEGER NOT NULL DEFAULT 0,
      PRIMARY KEY(user_id)
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS folders (
      folder_id INTEGER PRIMARY KEY AUTOINCREMENT,
      folder_name TEXT NOT NULL,
      folder_color TEXT NOT NULL DEFAULT 'Blue'
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS tasks (
      task_id INTEGER PRIMARY KEY AUTOINCREMENT,
      folder_id INTEGER NOT NULL,
      title TEXT NOT NULL,
      description TEXT,
      priority INTEGER,
      deadline DATETIME,
      reminder_time DATETIME,
      repeat_interval TEXT,
      gps_location TEXT,
      task_color TEXT,
      status INTEGER NOT NULL,
      FOREIGN KEY (folder_id) REFERENCES folders(folder_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS today_tasks (
      task_id INTEGER NOT NULL UNIQUE,
      PRIMARY KEY(task_id),
      FOREIGN KEY (task_id) REFERENCES tasks(task_id)
      ON UPDATE NO ACTION ON DELETE NO ACTION
    )
    ''');

    await db.insert('users', {
      'user_id': 1,
      'username': 'No username',
      'email': 'No email',
      'rating': 0,
      'succesful_tasks': 0,
      'average_tasks_per_day': 0,
    });

    await db.insert('folders', {
      'folder_id': 1,
      'folder_name': 'None',
      'folder_color': 'Blue',
    });
  }

  Future close() async {
    final db = await database_punctuality.database;
    db.close();
  }

  // --------------------------------------- Task -----------------------------------------------

  Future<int> insertTask(Task task) async {
    try {
      final db = await database_punctuality.database;
      return await db.insert('tasks', task.toMap());
    } catch (e) {
      print('Error inserting task: $e');
      return -1;
    }
  }

  Future<List<Task>> getTasks() async {
    final db = await database_punctuality.database;
    final result = await db.query('tasks');
    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<List<Task>> getTodayTasks() async {
    final db = await database_punctuality.database;
    final result = await db.query('tasks');
    List<Task> allTasks = result.map((json) => Task.fromMap(json)).toList();
    for(int i = 0; i < allTasks.length; i++)
    {
      if (allTasks[i].status < 2) {
        allTasks.removeAt(i);
      }
    }
    return allTasks;
  }

  Future<List<Task>> getTasksByFolderName(String folderName) async {
    final db = await database_punctuality.database;

    final result = await db.rawQuery(
        ''' SELECT tasks.* FROM tasks JOIN folders ON tasks.folder_id = folders.folder_id WHERE folders.folder_name = ? ''',
        [folderName]);

    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<int> updateTask(Task task) async {
    try {
      final db = await database_punctuality.database;
      return await db.update('tasks', task.toMap(),
          where: 'task_id = ?', whereArgs: [task.id]);
    } catch (e) {
      print('Error updating task: $e');
      return -1;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final db = await database_punctuality.database;
      return await db.delete('tasks', where: 'task_id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting task: $e');
      return -1;
    }
  }

// --------------------------------------- Profile -----------------------------------------------

  Future<Profile?> getProfile() async {
    final db = await database_punctuality.database;
    final result = await db.query('users');
    if (result.isNotEmpty) {
      print('Profile found: ${result.first}');
      return Profile.fromMap(result.first);
    } else {
      print('No profile found');
      return null;
    }
  }

  Future<int> updateProfile(Profile profile) async {
    try {
      final db = await database_punctuality.database;
      return await db.update('users', profile.toMap(),
          where: 'user_id = ?', whereArgs: [profile.userId]);
    } catch (e) {
      print('Error updating profile: $e');
      return -1;
    }
  }

// --------------------------------------- Folder -----------------------------------------------

  Future<int> insertFolder(Folder folder) async {
    try {
      final db = await database_punctuality.database;
      return await db.insert('folders', folder.toMap());
    } catch (e) {
      print('Error inserting folder: $e');
      return -1;
    }
  }

  Future<List<Folder>> getFolders() async {
    final db = await database_punctuality.database;
    final result = await db.query('folders');
    return result.map((json) => Folder.fromMap(json)).toList();
  }

  Future<int> updateFolder(Folder folder) async {
    try {
      final db = await database_punctuality.database;
      return await db.update('folders', folder.toMap(),
          where: 'folder_id = ?', whereArgs: [folder.folderId]);
    } catch (e) {
      print('Error updating folder: $e');
      return -1;
    }
  }

  Future<int> deleteFolder(int id) async {
    try {
      final db = await database_punctuality.database;
      return await db
          .delete('folders', where: 'folder_id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting folder: $e');
      return -1;
    }
  }
}
