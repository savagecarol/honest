
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:honest/models/task.dart';
import 'package:honest/services/Firestore_service.dart';
import 'package:honest/services/firebase_service.dart';


class AddController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  // Form controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final counterController = TextEditingController(text: '1');
  
  // Form state
  final RxBool unlimited = false.obs;
  final RxString countUnit = 'days'.obs;
  final RxInt counter = 1.obs;
  final RxBool isLoading = false.obs;

  // Available units
  final List<String> countUnits = ['days', 'months', 'years'];

  @override
  void onInit() {
    super.onInit();
    // Initialize counter controller with default value
    counterController.text = '1';
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    counterController.dispose();
    super.onClose();
  }

  void toggleUnlimited(bool value) {
    unlimited.value = value;
  }

  void setCountUnit(String unit) {
    countUnit.value = unit;
  }

  void incrementCounter() {
    counter.value++;
    counterController.text = counter.value.toString();
  }

  void decrementCounter() {
    if (counter.value > 1) {
      counter.value--;
      counterController.text = counter.value.toString();
    }
  }

  Future<void> submitTask() async {
    // Validation
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a title',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final userId = _firebaseService.getCurrentUserId();
    if (userId == null) {
      Get.snackbar(
        'Error',
        'User not authenticated',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      final task = Task(
        uid: '', // Will be set by Firestore
        userId: userId,
        title: titleController.text.trim(),
        description: descriptionController.text.trim().isEmpty 
            ? null 
            : descriptionController.text.trim(),
        postDescription: null,
        countUnit: unlimited.value ? null : countUnit.value,
        counter: unlimited.value ? null : counter.value,
        unlimited: unlimited.value,
        createdAt: DateTime.now(),
        completedAt: null,
      );

      final result = await _firestoreService.createTask(task);

      if (result != null) {
        Get.snackbar(
          'Success',
          'Task created successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        
        // Clear form
        titleController.clear();
        descriptionController.clear();
        unlimited.value = false;
        countUnit.value = 'days';
        counter.value = 1;
        
        // Navigate back or to tasks page
        // Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed to create task',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}