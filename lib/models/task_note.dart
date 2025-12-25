

import 'package:json_annotation/json_annotation.dart';
part 'task_note.g.dart';

@JsonSerializable()
class TaskNote {
  final String id;
  final String content;
  final DateTime createdAt;

  const TaskNote({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  factory TaskNote.fromJson(Map<String, dynamic> json) => _$TaskNoteFromJson(json);
  Map<String, dynamic> toJson() => _$TaskNoteToJson(this);

}