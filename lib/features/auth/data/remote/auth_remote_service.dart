import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserRole { admin, user, unknown }

class AuthRemoteService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign up with email and password
  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the created user
      User? user = userCredential.user;

      if (user != null) {
        // Send email verification
        await user.sendEmailVerification();
        
        // Save additional user data to Firestore
        await _fireStore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return user;
      }
    } on FirebaseAuthException catch (e) {
      throw Exception("FirebaseAuth Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: $e");
    }
    return null;
  }

  // Check if current user is an admin
  Future<bool> isAdmin() async {
    if (currentUser?.uid == null) return false;

    try {
      DocumentSnapshot adminDoc =
          await _fireStore.collection('admins').doc(currentUser?.uid).get();

      return adminDoc.exists;
    } catch (e) {
      print('Error checking admin status: $e');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Check if user is signed in
  bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  // Get user ID
  String? getUserId() {
    return _auth.currentUser?.uid;
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Delete user account
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Check if email is verified
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }

  // Reload user to get latest email verification status
  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  // Helper method to handle Firebase Auth Exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email & Password accounts are not enabled.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Log in again before retrying.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
