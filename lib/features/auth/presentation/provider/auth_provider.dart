import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/auth/data/remote/auth_remote_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRemoteService authRemoteService;
  final UserService userService;

  AuthProvider({
    required this.authRemoteService,
    required this.userService,
  });

  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false; // New state for authentication check

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated =>
      _isAuthenticated; // Getter for authentication state

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      User? user = await authRemoteService.signUp(
        email: email,
        password: password,
        name: name,
        role: role,
      );

      if (user != null) {
        userService.setUserData(
          uid: user.uid,
          name: name,
          email: email,
          role: role,
        );
        // Don't mark as authenticated until email is verified
        _isAuthenticated = false;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = "An error occurred: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      UserCredential userCredential =
          await authRemoteService.signInWithEmailAndPassword(
        email,
        password,
      );

      if (userCredential.user != null) {
        // Reload user to get latest email verification status
        await authRemoteService.reloadUser();
        
        // Check if email is verified
        if (!authRemoteService.isEmailVerified()) {
          _errorMessage = 'Please verify your email before logging in. Check your inbox for the verification email.';
          _isAuthenticated = false;
        } else {
          await userService.loadUserData();
          _isAuthenticated = true; // User is authenticated
        }
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = "An error occurred: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await authRemoteService.signOut();
    userService.clearUserData();
    _isAuthenticated = false; // Mark user as logged out
    notifyListeners();
  }

  Future<void> checkAuthentication() async {
    User? user = authRemoteService.currentUser;

    if (user != null) {
      // Reload user to get latest email verification status
      await authRemoteService.reloadUser();
      
      // Check if email is verified
      if (authRemoteService.isEmailVerified()) {
        await userService.loadUserData();
        _isAuthenticated = true; // User is authenticated
      } else {
        _isAuthenticated = false; // Email not verified
      }
    } else {
      _isAuthenticated = false; // User is not authenticated
    }
    notifyListeners();
  }

  // Resend email verification
  Future<void> resendEmailVerification() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await authRemoteService.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = "An error occurred: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
