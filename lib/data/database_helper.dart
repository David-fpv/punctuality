import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:first_application/models/task_model.dart';
import 'package:first_application/models/profile_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance =
      DatabaseHelper._init(); // переименновать instance!!!!!
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo_test3.db');
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
      rating INTEGER,
      succesful_tasks INTEGER,
      average_tasks_per_day INTEGER,
      PRIMARY KEY(user_id)
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS folders (
      folder_id INTEGER NOT NULL UNIQUE,
      folder_name TEXT NOT NULL,
      folder_color TEXT,
      PRIMARY KEY(folder_id)
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
  }

  // --------------------------------------- Task -----------------------------------------------

  Future<int> insertTask(Task task) async {
    try {
      final db = await instance.database;
      return await db.insert('tasks', task.toMap());
    } catch (e) {
      print('Error inserting task: $e');
      return -1;
    }
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');
    return result.map((json) => Task.fromMap(json)).toList();
  }

  Future<int> updateTask(Task task) async {
    try {
      final db = await instance.database;
      return await db.update('tasks', task.toMap(),
          where: 'task_id = ?', whereArgs: [task.id]);
    } catch (e) {
      print('Error updating task: $e');
      return -1;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final db = await instance.database;
      return await db.delete('tasks', where: 'task_id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting task: $e');
      return -1;
    }
  }

// --------------------------------------- Profile -----------------------------------------------

  Future<Profile?> getProfile() async {
    final db = await instance.database;
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
      final db = await instance.database;
      return await db.update('users', profile.toMap(),
          where: 'user_id = ?', whereArgs: [profile.userId]);
    } catch (e) {
      print('Error updating profile: $e');
      return -1;
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
