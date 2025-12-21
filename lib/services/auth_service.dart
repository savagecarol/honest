import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:honest/services/firestore_service.dart';
import 'package:honest/models/app_user.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    serverClientId: '193038228192-224io6lvkeh8qnurso0hiqlerbdnoalc.apps.googleusercontent.com',
  );

  RxBool isAuthenticated = false.obs;
  RxBool isLoading = true.obs;
  Rx<AppUser?> currentAppUser = Rx<AppUser?>(null);

  User? get currentUser => _auth.currentUser;

  @override
  void onInit() {
    super.onInit();
    _initAuth();
  }

  /// Initialize auth state listener
  void _initAuth() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        isAuthenticated.value = true;
        await _loadOrCreateUser(user);
      } else {
        isAuthenticated.value = false;
        currentAppUser.value = null;
      }
      isLoading.value = false;
    });
  }

  Future<void> _loadOrCreateUser(User firebaseUser) async {
    try {
      AppUser? existingUser = await _firestoreService.getUser(firebaseUser.uid);
      if (existingUser != null) {
        currentAppUser.value = existingUser;
        debugPrint('User loaded: ${existingUser.email}');
      } else {
        final newUser = AppUser.fromFirebase(firebaseUser);
        final createdUser = await _firestoreService.createUser(newUser);
        
        if (createdUser != null) {
          currentAppUser.value = createdUser;
          debugPrint('New user created: ${createdUser.email}');
        }
      }
    } catch (e) {
      debugPrint('Error loading/creating user: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;  
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        isLoading.value = false;
        return;
      }
      final GoogleSignInAuthentication auth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      await _auth.signInWithCredential(credential);
      await _loadOrCreateUser(_auth.currentUser!);
      
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      isLoading.value = false;
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      currentAppUser.value = null;
    } catch (e) {
      debugPrint('Sign out error: $e');
      rethrow;
    }
  }

  /// Manually reload user from Firestore
  Future<void> reloadUser() async {
    if (currentUser != null) {
      await _loadOrCreateUser(currentUser!);
    }
  }
}