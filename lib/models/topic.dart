import 'dart:convert';

class Topic {
  final int id;
  final int longId;
  final int parentId;
  final String content;
  final int orderIndex;

  const Topic({
    required this.id,
    required this.longId,
    required this.parentId,
    required this.content,
    required this.orderIndex,
  });

  static const String tableName = 'Topic';
  static const String columnId = 'id';
  static const String columnLongId = 'longId';
  static const String columnParentId = 'parentId';
  static const String columnContent = 'content';
  static const String columnOrderIndex = 'orderIndex';

  // Convert a Map to a Topic instance
  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['id'],
      longId: map['longId'],
      parentId: map['parentId'],
      content: map['content'],
      orderIndex: map['orderIndex'],
    );
  }

  // Convert a Topic instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'longId': longId,
      'parentId': parentId,
      'content': content,
      'orderIndex': orderIndex,
    };
  }

  // Convert a JSON string to a Topic instance
  factory Topic.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return Topic.fromMap(map);
  }

  // Convert a Topic instance to a JSON string
  String toJson() {
    final Map<String, dynamic> map = toMap();
    return json.encode(map);
  }
}
