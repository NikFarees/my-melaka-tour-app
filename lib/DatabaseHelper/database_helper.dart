import 'dart:async';
import 'package:mymelaka/JsonModel/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone INTEGER,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tourbook (
        bookId INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        startTour TEXT,
        endTour TEXT,
        tourPackage TEXT,
        noPeople INTEGER,
        packagePrice REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE admin (
        adminId INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');

    await db.rawInsert('''
      INSERT INTO admin(username, password)
      VALUES('admin', 'admin')
    ''');
  }

  // Register User Function
  Future<int> insertUser(Users user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  // Insert TourBook Function
  Future<int> insertTourBook(TourBook tourBook) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the TourBook into the correct table.
    return await db.insert(
      'tourbook',
      tourBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get certain User Function
  Future<Users?> getUser(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return Users.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Get certain Admin Function
  Future<Admin?> getAdmin(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'admin',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return Admin.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Get all Users Function
  Future<List<Users>> getAllUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return Users.fromMap(maps[i]);
    });
  }

  // Get all TourBookings Function
  Future<List<TourBook>> getAllTourBookings() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('tourbook');

    return List.generate(maps.length, (i) {
      return TourBook.fromMap(maps[i]);
    });
  }

  // Update User Function
  Future<void> updateUser(Users user) async {
    Database db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'userId = ?',
      whereArgs: [user.userId],
    );
  }

  // Delete User Function
  Future<void> deleteUser(int userId) async {
    Database db = await database;
    await db.delete(
      'users',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Delete TourBookings by User ID Function
  Future<void> deleteTourBookingsByUserId(int userId) async {
    Database db = await database;
    await db.delete(
      'tourbook',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // Get TourBookings by User ID Function
  Future<List<TourBook>> getTourBookingsByUserId(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tourbook',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return TourBook.fromMap(maps[i]);
    });
  }

  // Check if Username is Registered Function
  Future<bool> isUsernameRegistered(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    return maps.isNotEmpty;
  }
}
