import 'package:seek_app/models/scanner.dart';
import 'package:seek_app/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
  await deleteDatabaseIfNecessary(); //eliminar BD
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> deleteDatabaseIfNecessary() async {
    String path = join(await getDatabasesPath(), 'scanner.db');
    await deleteDatabase(path); 
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'scanner.db');
    return await openDatabase(
      path,
      version: 1, 
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE pin (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pin TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE scanned_codes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT,
            date TEXT,  -- Almacenaremos la fecha como una cadena ISO8601
            description TEXT,
            userId INTEGER,
            FOREIGN KEY(userId) REFERENCES users(id)
          )
        ''');
      },
    );
  }

  Future<void> insertScannedCode(Scan scan) async {
    final db = await database;
    await db.insert(
      'scanned_codes',
      scan.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace, 
    );
  }
  Future<void> savePin(String pin) async {
    final db = await database;
    await db.insert(
      'pin',
      {'pin': pin},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getPin() async {
    final db = await database;
    var result = await db.query('pin', limit: 1);
    if (result.isNotEmpty) {
      return result.first['pin'] as String?;
    }
    return null;
  }
  
  Future<List<Scan>> getScannedCodes() async {
    final db = await database;
    final result = await db.query('scanned_codes');
    return result.map((e) => Scan.fromMap(e)).toList();
  }

  Future<void> deleteScannedCode(int id, Scan scan) async {
    final db = await database;
    await db.delete(
      'scanned_codes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<User?> getUser() async {
    final db = await database;
    final result = await db.query('users', limit: 1);

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap());
  }
}
