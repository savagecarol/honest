import 'package:get/get.dart';
import 'package:honest/models/app_user.dart';
import 'package:honest/models/task.dart';
import 'package:honest/services/auth_service.dart';
import 'package:honest/services/firestore_service.dart';

class TaskController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final RxList<Task> myCompletedTasks = <Task>[].obs;
  final RxBool isLoading = true.obs;

  AppUser? get currentUser => _authService.currentAppUser.value;

  @override
  void onInit() {
    super.onInit();
    loadMyCompletedTasks();
  }

  @override
  void onReady() {
    super.onReady();
    ever(_authService.currentAppUser, (_) => loadMyCompletedTasks());
  }

  Future<void> loadMyCompletedTasks() async {
    if (currentUser == null) return;
    
    isLoading.value = true;
    try {
      final tasks = await _firestoreService.getCompletedTasks(currentUser!.uid);
      myCompletedTasks.value = tasks;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshAll() async {
    await loadMyCompletedTasks();
  }
}