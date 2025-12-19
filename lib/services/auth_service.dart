import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: '193038228192-224io6lvkeh8qnurso0hiqlerbdnoalc.apps.googleusercontent.com',
  );

  RxBool isAuthenticated = false.obs;
  RxBool isLoading = true.obs;

  User? get currentUser => _auth.currentUser;


Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) return; 
    final GoogleSignInAuthentication auth = await account.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    await _auth.signInWithCredential(credential);

  } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }
  
}
