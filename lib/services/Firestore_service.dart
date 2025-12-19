import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honest/models/task.dart';

class FirestoreService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String tasksCollection = 'tasks';

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

  Future<List<Task>> getUserTasks(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(tasksCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Task.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error getting user tasks: $e');
      return [];
    }
  }


  Future<List<Task>> getActiveTasks(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(tasksCollection)
          .where('userId', isEqualTo: userId)
          .where('completedAt', isNull: true)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Task.fromJson(doc.data()))
          .toList();
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
          .where('completedAt', isNull: false)
          .orderBy('completedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Task.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error getting completed tasks: $e');
      return [];
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

  // Update task
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

  Stream<List<Task>> streamActiveTasks(String userId) {
    return _firestore
        .collection(tasksCollection)
        .where('userId', isEqualTo: userId)
        .where('completedAt', isNull: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromJson(doc.data()))
            .toList());
  }

  // Stream completed tasks
  Stream<List<Task>> streamCompletedTasks(String userId) {
    return _firestore
        .collection(tasksCollection)
        .where('userId', isEqualTo: userId)
        .where('completedAt', isNull: false)
        .orderBy('completedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromJson(doc.data()))
            .toList());
  }
}
