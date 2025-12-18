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

    const AppUser({
    required this.uid,
    required this.email,
    this.name,
    this.photoUrl,
    this.role = 'user',
    required this.createdAt,
  });


  factory AppUser.fromFirebase(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName,
      photoUrl: user.photoURL,
      createdAt: DateTime.now(),
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>_$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
