import 'dart:io';

import 'package:flutter/services.dart';
import 'package:routing_app/services/log_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SqliteService {
  static SqliteService? _instance;

  static SqliteService get instance => _instance ??= SqliteService._();

  SqliteService._();

  // Table and column names
  static const String tableName = "example_table";
  static const String columnId = "id";
  static const String columnName = "name";
  static const String columnAge = "age";

  late Database database;

  Future<void> init() async {
    String? path = await copyDatabaseFile('data.db');
    if (path == null) {
      printError('sqliteService init error');
      return;
    }

    try {
      database = await openDatabase(path);
    } catch (e) {
      printError('Open database failed: $e');
    }
  }

  Future<String?> copyDatabaseFile(String assetFileName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, assetFileName);

    if (await File(path).exists()) {
      printWarning('Database already exists at $path');
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
}
