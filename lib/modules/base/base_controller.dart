import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:honest/models/app_user.dart';
import 'package:honest/services/firebase_service.dart';

class BaseController extends GetxController {
  final FirebaseService _firebaseService = Get.find<FirebaseService>();
  final Rx<AppUser?> user = Rx<AppUser?>(null);
  final RxInt currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    _loadUser();
  }
  
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index); 
  }

  Future<void> _loadUser() async {
    final firebaseUser = await _firebaseService.getUser();
    if (firebaseUser != null) {
      user.value = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? 'No Name',
        createdAt: DateTime.now(),
      );
    }
  }
}
