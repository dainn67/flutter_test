import 'dart:io';

import 'package:flutter/services.dart';
import 'package:routing_app/services/log_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SqliteService {
  static SqliteService? _instance;
  static const int _databaseVersion = 1;  // Add version control
  bool _isInitialized = false;  // Track initialization state

  static SqliteService get instance => _instance ??= SqliteService._();

  SqliteService._();

  // Table and column names
  static const String tableName = "example_table";
  static const String columnId = "id";
  static const String columnName = "name";
  static const String columnAge = "age";

  late Database database;

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    if (_isInitialized) return;  // Prevent multiple initializations

    String? path = await copyDatabaseFile('data.db');
    if (path == null) {
      printError('sqliteService init error');
      return;
    }

    try {
      database = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
      _isInitialized = true;
    } catch (e) {
      printError('Open database failed: $e');
      rethrow;  // Propagate error to caller
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    //TODO: Handle database migrations here
  }

  Future<void> close() async {
    if (_isInitialized) {
      await database.close();
      _isInitialized = false;
    }
  }

  Future<String?> copyDatabaseFile(String assetFileName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, assetFileName);

    if (await File(path).exists()) {
      printSuccess('Database already exists at $path');
      return path;
    }

    final assetData = await loadDatabaseAsset();
    if (assetData == null) return null;

    await File(path).writeAsBytes(assetData);
    return path;
  }

  Future<Uint8List?> loadDatabaseAsset() async {
    try {
      final data = await rootBundle.load('assets/databases/data.db');
      return data.buffer.asUint8List();
    } catch (e) {
      printError('Error loading asset: $e');
      return null;
    }
  }

  Future<void> closeDatabase() async {
    await close();
  }
}
