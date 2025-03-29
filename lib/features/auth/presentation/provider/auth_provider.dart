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
        _isAuthenticated = true; // Mark user as authenticated
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
        await userService.loadUserData();
        _isAuthenticated = true; // User is authenticated
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
      await userService.loadUserData();
      _isAuthenticated = true; // User is authenticated
    } else {
      _isAuthenticated = false; // User is not authenticated
    }
    notifyListeners();
  }
}
