import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
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
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  // Helper to check if task is completed
  bool get isCompleted => completedAt != null;

  // Copy with method for updates
  Task copyWith({
    String? uid,
    String? userId,
    String? title,
    String? description,
    String? postDescription,
    String? countUnit,
    int? counter,
    bool? unlimited,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Task(
      uid: uid ?? this.uid,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      postDescription: postDescription ?? this.postDescription,
      countUnit: countUnit ?? this.countUnit,
      counter: counter ?? this.counter,
      unlimited: unlimited ?? this.unlimited,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
