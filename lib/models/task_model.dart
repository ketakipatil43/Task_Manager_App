import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime createdAt;
  final ParseObject raw;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.createdAt,
    required this.raw,
  });

  factory TaskModel.fromParse(ParseObject o) {
    return TaskModel(
      id: o.objectId ?? '',
      title: o.get('title') ?? '',
      description: o.get('description') ?? '',
      completed: o.get('completed') ?? false,
      createdAt: o.createdAt ?? DateTime.now(),
      raw: o,
    );
  }
}
