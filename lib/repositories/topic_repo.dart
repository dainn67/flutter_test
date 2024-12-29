import 'package:routing_app/models/topic.dart';
import 'package:routing_app/services/sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

import '../services/log_service.dart';

class TopicRepo {
  TopicRepo._();

  static Future<List<Topic>?> getTopicsByParentId(int parentId) async {
    Database database = SqliteService.instance.database;

    String sql = 'SELECT * FROM ${Topic.tableName} WHERE ${Topic.columnParentId} = ?';

    try {
      final result = [
        ...await database.rawQuery(sql, [parentId])
      ];

      return result.map((e) => Topic.fromMap(e)).toList();
    } catch (e) {
      printError('Query error: $e');
      return null;
    }
  }
}
