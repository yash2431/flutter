import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('matrimony.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, fileName);

      return await openDatabase(
        path,
        version: 1,
        onCreate: _createDB,
        onConfigure: (db) async {
          await db.execute("PRAGMA foreign_keys = ON");
        },
      );
    } catch (e) {
      print("Database Initialization Error: $e");
      rethrow;
    }
  }


  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT, -- ✅ Let SQLite auto-generate ID
      name TEXT,
      email TEXT UNIQUE,
      mobile TEXT,
      dob TEXT,
      age INTEGER,
      city TEXT,
      gender TEXT,
      hobbies TEXT,
      password TEXT,
      isFavorite INTEGER DEFAULT 0
    )
  ''');

    await db.execute('''
    CREATE TABLE favorite_users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userId INTEGER UNIQUE,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
    )
  ''');
  }


  // Insert User
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    try {
      int id = await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
      print("✅ User inserted with ID: $id"); // Debugging
      return id;
    } catch (e) {
      print("❌ Database Insert Error: $e"); // ✅ This will show the exact error
      return -1;
    }
  }



  // Get All Users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await instance.database;
    List<Map<String, dynamic>> users = await db.query('users');

    print("✅ Users Fetched from DB: ${users.length}");
    for (var user in users) {
      print("User: $user"); // ✅ Debugging
    }

    return users;
  }



  // Get User by ID
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  // Update User
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  // Delete User
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Add to Favorites
  Future<int> addToFavorites(int userId) async {
    final db = await instance.database;
    try {
      return await db.insert('favorite_users', {'userId': userId},
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      print("Error adding to favorites: $e");
      return -1;
    }
  }

  Future<void> toggleFavorite(int userId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'favorite_users',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (result.isEmpty) {
      await db.insert('favorite_users', {'userId': userId});
    } else {
      await db.delete('favorite_users', where: 'userId = ?', whereArgs: [userId]);
    }
  }



  // Remove from Favorites
  Future<int> removeFromFavorites(int userId) async {
    final db = await instance.database;
    return await db.delete('favorite_users', where: 'userId = ?', whereArgs: [userId]);
  }

  // Get Favorite Users
  Future<List<Map<String, dynamic>>> getFavoriteUsers() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT users.* FROM users
    INNER JOIN favorite_users ON users.id = favorite_users.userId
  ''');
  }

}
