import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ------------------ Authentication ------------------

  // Sign up with email & password
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Login with email & password
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Reset password via email
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ------------------ User Profile ------------------

  /// Save or update user profile in Firestore
  Future<void> saveUserProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set(data, SetOptions(merge: true));
    }
  }

  /// Fetch user profile from Firestore
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await _firestore.collection('users').doc(user.uid).get();
    }
    return null;
  }
}
