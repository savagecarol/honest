import 'package:get/get.dart';
import 'package:honest/models/app_user.dart';
import 'package:honest/modules/base/base_controller.dart';
import 'package:honest/routes/app_routes.dart';
import 'package:honest/services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final RxBool isLoading = false.obs;

  Rx<AppUser?> get user {
    final baseController = Get.find<BaseController>();
    return baseController.user;
  }

  @override
  void onInit() {
    super.onInit();
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
}