// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/user.dart';
// import '../services/auth_service.dart';

// class AuthProvider with ChangeNotifier {
//   final FirebaseService _authService = FirebaseService();
//   User? user;
//   UserModel? profile;

//   // Listen to auth state
//   void listenToAuthChanges() {
//     _authService.authState.listen((firebaseUser) async {
//       user = firebaseUser;
//       if (user != null) {
//         profile = await _authService.getUserProfile(user!.uid);
//       } else {
//         profile = null;
//       }
//       notifyListeners();
//     });
//   }

//   Future<void> signUp(String email, String password) async {
//     user = await _authService.signUp(email, password);
//     notifyListeners();
//   }

//   Future<void> signIn(String email, String password) async {
//     user = await _authService.signIn(email, password);
//     notifyListeners();
//   }

//   Future<void> signOut() async {
//     await _authService.signOut();
//     user = null;
//     profile = null;
//     notifyListeners();
//   }

//   Future<void> saveProfile(UserModel newProfile) async {
//     await _authService.saveUserProfile(newProfile);
//     profile = newProfile;
//     notifyListeners();
//   }
// }
