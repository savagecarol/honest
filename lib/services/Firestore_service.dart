import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honest/models/task.dart';
import 'package:honest/models/app_user.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String tasksCollection = 'tasks';
  static const String usersCollection = 'users';
  static const int maxFriends = 20;

  Future<List<Task>> getActiveTasks(String userId) async {
  try {
    final snapshot = await _firestore
        .collection(tasksCollection)
        .where('userId', isEqualTo: userId)
        .get();

    // Filter and sort in code
    final tasks = snapshot.docs
        .map((doc) => Task.fromJson(doc.data()))
        .where((task) => task.completedAt == null)
        .toList();
    
    // Sort by createdAt in code
    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return tasks;
  } catch (e) {
    debugPrint('Error getting active tasks: $e');
    return [];
  }
}

Future<List<Task>> getCompletedTasks(String userId) async {
  try {
    final snapshot = await _firestore
        .collection(tasksCollection)
        .where('userId', isEqualTo: userId)
        .get();

    // Filter and sort in code
    final tasks = snapshot.docs
        .map((doc) => Task.fromJson(doc.data()))
        .where((task) => task.completedAt != null)
        .toList();
    
    // Sort by completedAt in code
    tasks.sort((a, b) => b.completedAt!.compareTo(a.completedAt!));
    
    return tasks;
  } catch (e) {
    debugPrint('Error getting completed tasks: $e');
    return [];
  }
}

Future<List<Task>> getUserTasks(String userId) async {
  try {
    final snapshot = await _firestore
        .collection(tasksCollection)
        .where('userId', isEqualTo: userId)
        .get();

    final tasks = snapshot.docs
        .map((doc) => Task.fromJson(doc.data()))
        .toList();
    
    // Sort by createdAt in code
    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return tasks;
  } catch (e) {
    debugPrint('Error getting user tasks: $e');
    return [];
  }
}

Stream<List<Task>> streamActiveTasks(String userId) {
  return _firestore
      .collection(tasksCollection)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
        final tasks = snapshot.docs
            .map((doc) => Task.fromJson(doc.data()))
            .where((task) => task.completedAt == null)
            .toList();
        
        // Sort by createdAt in code
        tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        
        return tasks;
      });
}

Stream<List<Task>> streamCompletedTasks(String userId) {
  return _firestore
      .collection(tasksCollection)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
        final tasks = snapshot.docs
            .map((doc) => Task.fromJson(doc.data()))
            .where((task) => task.completedAt != null)
            .toList();
        
        // Sort by completedAt in code
        tasks.sort((a, b) => b.completedAt!.compareTo(a.completedAt!));
        
        return tasks;
      });
}


  // ========== TASK METHODS (unchanged) ==========
  
  Future<Task?> createTask(Task task) async {
    try {
      final docRef = _firestore.collection(tasksCollection).doc();
      final taskWithId = task.copyWith(uid: docRef.id);
      
      await docRef.set(taskWithId.toJson());
      return taskWithId;
    } catch (e) {
      debugPrint('Error creating task: $e');
      return null;
    }
  }

  Future<Task?> getTask(String taskId) async {
    try {
      final doc = await _firestore
          .collection(tasksCollection)
          .doc(taskId)
          .get();

      if (doc.exists) {
        return Task.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting task: $e');
      return null;
    }
  }

  Future<bool> completeTask(String taskId) async {
    try {
      await _firestore
          .collection(tasksCollection)
          .doc(taskId)
          .update({'completedAt': FieldValue.serverTimestamp()});
      return true;
    } catch (e) {
      debugPrint('Error completing task: $e');
      return false;
    }
  }

  Future<bool> updateTask(Task task) async {
    try {
      await _firestore
          .collection(tasksCollection)
          .doc(task.uid)
          .update(task.toJson());
      return true;
    } catch (e) {
      debugPrint('Error updating task: $e');
      return false;
    }
  }

  Future<bool> deleteTask(String taskId) async {
    try {
      await _firestore
          .collection(tasksCollection)
          .doc(taskId)
          .delete();
      return true;
    } catch (e) {
      debugPrint('Error deleting task: $e');
      return false;
    }
  }


  // ========== USER METHODS ==========

  /// Create a new user document
  Future<AppUser?> createUser(AppUser user) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(user.uid)
          .set(user.toJson());
      return user;
    } catch (e) {
      debugPrint('Error creating user: $e');
      return null;
    }
  }

  /// Get user by ID
  Future<AppUser?> getUser(String userId) async {
    try {
      final doc = await _firestore
          .collection(usersCollection)
          .doc(userId)
          .get();

      if (doc.exists) {
        return AppUser.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }

  /// Update user document
  Future<bool> updateUser(AppUser user) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(user.uid)
          .update(user.toJson());
      return true;
    } catch (e) {
      debugPrint('Error updating user: $e');
      return false;
    }
  }

  /// Add a friend to user's friend list
  Future<String?> addFriend(String userId, String friendId) async {
    try {
      // Get current user data
      final userDoc = await _firestore
          .collection(usersCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return 'User not found';
      }

      final user = AppUser.fromJson(userDoc.data()!);

      // Check if already friends
      if (user.friends.contains(friendId)) {
        return 'Already friends';
      }

      // Check friend limit
      if (user.friends.length >= maxFriends) {
        return 'Maximum $maxFriends friends allowed';
      }

      // Check if friend exists
      final friendDoc = await _firestore
          .collection(usersCollection)
          .doc(friendId)
          .get();

      if (!friendDoc.exists) {
        return 'Friend not found';
      }

      // Add friend to list
      await _firestore
          .collection(usersCollection)
          .doc(userId)
          .update({
        'friends': FieldValue.arrayUnion([friendId])
      });

      return null; // Success
    } catch (e) {
      debugPrint('Error adding friend: $e');
      return 'Error adding friend: $e';
    }
  }

  /// Remove a friend from user's friend list
  Future<String?> removeFriend(String userId, String friendId) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(userId)
          .update({
        'friends': FieldValue.arrayRemove([friendId])
      });

      return null; // Success
    } catch (e) {
      debugPrint('Error removing friend: $e');
      return 'Error removing friend: $e';
    }
  }

  /// Get list of friend AppUser objects
  Future<List<AppUser>> getFriends(String userId) async {
    try {
      final userDoc = await _firestore
          .collection(usersCollection)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return [];
      }

      final user = AppUser.fromJson(userDoc.data()!);

      if (user.friends.isEmpty) {
        return [];
      }

      // Get all friend documents
      final friendDocs = await Future.wait(
        user.friends.map((friendId) => 
          _firestore.collection(usersCollection).doc(friendId).get()
        )
      );

      return friendDocs
          .where((doc) => doc.exists)
          .map((doc) => AppUser.fromJson(doc.data()!))
          .toList();
    } catch (e) {
      debugPrint('Error getting friends: $e');
      return [];
    }
  }

  /// Stream user data
  Stream<AppUser?> streamUser(String userId) {
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? AppUser.fromJson(doc.data()!) : null);
  }

}