import 'package:get/get.dart';
import 'package:honest/models/task.dart';
import 'package:honest/models/app_user.dart';
import 'package:honest/services/auth_service.dart';
import 'package:honest/services/firestore_service.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final RxList<Task> myTasks = <Task>[].obs;
  final RxList<Task> friendTasks = <Task>[].obs;
  final RxList<AppUser> friends = <AppUser>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isFriendsLoading = false.obs;

  AppUser? get currentUser => _authService.currentAppUser.value;

  @override
  void onInit() {
    super.onInit();
    loadMyTasks();
    loadFriends();
  }

  // This will be called when user returns to HomeView
  @override
  void onReady() {
    super.onReady();
    // Refresh data when view is ready
    ever(_authService.currentAppUser, (_) => loadMyTasks());
  }

  /// Load current user's active tasks
  Future<void> loadMyTasks() async {
    if (currentUser == null) return;
    
    isLoading.value = true;
    try {
      final tasks = await _firestoreService.getActiveTasks(currentUser!.uid);
      myTasks.value = tasks;
    } finally {
      isLoading.value = false;
    }
  }

  /// Load friends and their tasks
  Future<void> loadFriends() async {
    if (currentUser == null) return;
    
    isFriendsLoading.value = true;
    try {
      // Get friends list
      final friendsList = await _firestoreService.getFriends(currentUser!.uid);
      friends.value = friendsList;

      // Get all friend tasks
      List<Task> allFriendTasks = [];
      for (var friend in friendsList) {
        final tasks = await _firestoreService.getActiveTasks(friend.uid);
        allFriendTasks.addAll(tasks);
      }
      
      // Sort by creation date
      allFriendTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      friendTasks.value = allFriendTasks;
    } finally {
      isFriendsLoading.value = false;
    }
  }

  /// Refresh all data
  Future<void> refreshAll() async {
    await Future.wait([
      loadMyTasks(),
      loadFriends(),
    ]);
  }

  /// Get friend name by userId
  String? getFriendName(String userId) {
    final friend = friends.firstWhereOrNull((f) => f.uid == userId);
    return friend?.name ?? friend?.email;
  }
}