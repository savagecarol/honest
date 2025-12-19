import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getUser() async {
      return _auth.currentUser;
  }
}
