import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:honest/models/task.dart';
import 'package:honest/models/task_note.dart';
import 'package:honest/services/firestore_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

import 'package:uuid/uuid.dart';


class TaskViewController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  final GlobalKey repaintKey = GlobalKey();
  
  final Rx<Task?> task = Rx<Task?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final TextEditingController noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final taskArg = Get.arguments as Task?;
    if (taskArg != null) {
      task.value = taskArg;
    }
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  Future<void> addNote() async {
    if (noteController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a note',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (task.value == null) return;

    isSaving.value = true;
    
    final newNote = TaskNote(
      id: const Uuid().v4(),
      content: noteController.text.trim(),
      createdAt: DateTime.now(),
    );

    final updatedNotes = List<TaskNote>.from(task.value!.notes)..add(newNote);
    final updatedTask = task.value!.copyWith(notes: updatedNotes);

    final success = await _firestoreService.updateTask(updatedTask);

    if (success) {
      task.value = updatedTask;
      noteController.clear();
      Get.snackbar(
        'Success',
        'Note added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to add note',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }

    isSaving.value = false;
  }
Future<void> deleteNote(String noteId) async {
  if (task.value == null) return;

  isSaving.value = true;

  final updatedNotes =
      task.value!.notes.where((n) => n.id != noteId).toList();

  final updatedTask = task.value!.copyWith(notes: updatedNotes);

  final success = await _firestoreService.updateTask(updatedTask);

  if (success) {
    task.value = updatedTask;
  }

  isSaving.value = false;
}


  Future<void> shareToInstagram() async {
    if (task.value == null) return;

    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        barrierDismissible: false,
      );

      // Capture the widget as an image
      RenderRepaintBoundary boundary = repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      // Save to temporary directory
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/task_story_${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(bytes);

      Get.back(); // Close loading dialog

      // Share the image
      await Share.shareXFiles(
        [XFile(imagePath)],
        text: 'Check out my progress on ${task.value!.title}!',
      );

      // Clean up
      await imageFile.delete();
    } catch (e) {
      Get.back(); // Close loading dialog if open
      Get.snackbar(
        'Error',
        'Failed to share: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
}