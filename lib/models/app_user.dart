import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final String uid;
  final String email;
  final String? name;
  final String? photoUrl;
  final String role;
  final DateTime createdAt;
  final List<String> friends;

  const AppUser({
    required this.uid,
    required this.email,
    this.name,
    this.photoUrl,
    this.role = 'user',
    required this.createdAt,
    this.friends = const [], 
  });

  factory AppUser.fromFirebase(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName,
      photoUrl: user.photoURL,
      createdAt: DateTime.now(),
      friends: const [],
    );
  }

  AppUser copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    String? role,
    DateTime? createdAt,
    List<String>? friends,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      friends: friends ?? this.friends,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}