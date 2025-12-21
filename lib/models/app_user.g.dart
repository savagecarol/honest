// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  photoUrl: json['photoUrl'] as String?,
  role: json['role'] as String? ?? 'user',
  createdAt: DateTime.parse(json['createdAt'] as String),
  friends:
      (json['friends'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'name': instance.name,
  'photoUrl': instance.photoUrl,
  'role': instance.role,
  'createdAt': instance.createdAt.toIso8601String(),
  'friends': instance.friends,
};
