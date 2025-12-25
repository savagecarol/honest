// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  uid: json['uid'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  postDescription: json['postDescription'] as String?,
  countUnit: json['countUnit'] as String?,
  counter: (json['counter'] as num?)?.toInt(),
  unlimited: json['unlimited'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  completedAt:
      json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
  notes:
      (json['notes'] as List<dynamic>?)
          ?.map((e) => TaskNote.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'uid': instance.uid,
  'userId': instance.userId,
  'title': instance.title,
  'description': instance.description,
  'postDescription': instance.postDescription,
  'countUnit': instance.countUnit,
  'counter': instance.counter,
  'unlimited': instance.unlimited,
  'createdAt': instance.createdAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'notes': instance.notes.map((e) => e.toJson()).toList(),
};
