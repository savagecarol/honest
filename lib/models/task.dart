import 'package:json_annotation/json_annotation.dart';
import 'task_note.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  final String uid;
  final String userId;
  final String title;
  final String? description;
  final String? postDescription;
  final String? countUnit;
  final int? counter;
  final bool unlimited;
  final DateTime createdAt;
  final DateTime? completedAt;
  final List<TaskNote> notes;

  const Task({
    required this.uid,
    required this.userId,
    required this.title,
    this.description,
    this.postDescription,
    this.countUnit,
    this.counter,
    required this.unlimited,
    required this.createdAt,
    this.completedAt,
    this.notes = const [],
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  bool get isCompleted => completedAt != null;

  Task copyWith({
    String? uid,
    List<TaskNote>? notes,
    DateTime? completedAt,
  }) {
    return Task(
      uid: uid ?? this.uid,
      userId: userId,
      title: title,
      description: description,
      postDescription: postDescription,
      countUnit: countUnit,
      counter: counter,
      unlimited: unlimited,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
    );
  }
}
