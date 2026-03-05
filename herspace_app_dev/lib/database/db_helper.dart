import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('herspace.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("DATABASE PATH: $path");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, nickname TEXT, 
  email TEXT UNIQUE, password TEXT, role TEXT
)
''');
  }

  // INSERT USER (SIGNUP)
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;

    try {
      final result = await db.insert(
        'users',
        user,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      print("USER INSERTED: $result");
      return result;
    } catch (e) {
      print("INSERT ERROR: $e");
      return 0;
    }
  }

  // LOGIN USER (checks role too)
  Future<List<Map<String, dynamic>>> loginUser(
    String email,
    String password,
    String role,
  ) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ? AND role = ?',
      whereArgs: [email, password, role],
    );

    return result;
  }
}
