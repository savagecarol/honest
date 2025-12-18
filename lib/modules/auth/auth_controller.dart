import 'package:get/get.dart';
import 'package:honest/services/auth_service.dart';

class AuthController extends GetxController  {

  final AuthService _authService = Get.find<AuthService>();

  RxBool isSigningIn = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isSigningIn.value = true;
      await _authService.signInWithGoogle();
    } catch (e) {
      Get.snackbar('Login Failed', 'Google sign-in failed');
    } finally {
      isSigningIn.value = false;
    }
  }

}