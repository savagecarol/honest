import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:honest/models/app_user.dart';

class HomeController extends GetxController {

  Rx<AppUser?> user = Rx<AppUser?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
     user = AppUser(uid: "f", email: "DSf", createdAt: DateTime.now()).obs;
  }
}
