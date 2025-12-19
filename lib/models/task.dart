
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String uid;
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
    required this.title,
    this.description,
    this.postDescription,
    this.countUnit,
    this.counter,
    required this.unlimited,
    required this.createdAt,
    this.completedAt,
  });
}
