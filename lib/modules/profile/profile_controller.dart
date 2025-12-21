import 'package:get/get.dart';
import 'package:honest/models/app_user.dart';
import 'package:honest/routes/app_routes.dart';
import 'package:honest/services/firestore_service.dart';
import 'package:honest/services/auth_service.dart';
import 'package:honest/services/firebase_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseService _firebaseService = Get.find<FirebaseService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final RxBool isLoading = false.obs;
  final Rx<AppUser?> user = Rx<AppUser?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _authService.signOut();
      Get.offAllNamed(Routes.signIn);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadUser() async {
    final firebaseUser = await _firebaseService.getUser();
    if (firebaseUser != null) {
      user.value = await _firestoreService.getUser(firebaseUser.uid);
    }
  }

  Future<void> refreshUser() async {
    await _loadUser();
  }
}
