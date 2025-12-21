import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:honest/core/custom/cusom_function.dart';
import 'package:honest/models/app_user.dart';
import 'package:honest/routes/app_routes.dart';
import 'package:honest/services/firestore_service.dart';
import 'package:honest/services/auth_service.dart';
import 'package:honest/services/firebase_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirebaseService _firebaseService = Get.find<FirebaseService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final RxBool isLoading = false.obs;
  final Rx<AppUser?> user = Rx<AppUser?>(null);
  late String? ratings;
  late String? privacyPolicy;
  late String? termsAndCondition;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
    _loadDetails();
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

  Future<void> _loadDetails() async {
    Map<String,String> map = await _firestoreService.getDetails();
    debugPrint('Details Map: $map');
    ratings = map['ratings'];
    privacyPolicy = map['privacyPolicy'];
    termsAndCondition = map['termsAndCondition'];
  }

  Future<void> refreshUser() async {
    await _loadUser();
  }

  Future<void> openLink(String? url) async {
  if(url == null || url == '')  {
   showErrorSnackbar(
      'Error',
      'Link is not available',
    );
    return;
  }
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri,mode: LaunchMode.externalApplication)) {
      showErrorSnackbar(
        'Error',
        'Failed to open link'
      );
   }
}

}
