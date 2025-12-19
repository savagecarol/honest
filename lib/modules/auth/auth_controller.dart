import 'package:get/get.dart';
import 'package:honest/core/custom/cusom_function.dart';
import 'package:honest/routes/app_routes.dart';
import 'package:honest/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  RxBool isSigningIn = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isSigningIn.value = true;
      await _authService.signInWithGoogle();
      if (_authService.currentUser != null) {
        Get.offAllNamed(Routes.base);
      } else {
        Get.offAllNamed(Routes.signIn);
      }
    } catch (e) {
      showErrorSnackbar('Login Failed', 'Google sign-in failed');
    } finally {
      isSigningIn.value = false;
    }
  }
}
