import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;

  UserService._internal();

  String? uid;
  String? name;
  String? email;
  String? role;

  Future<void> loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
          uid = data['uid'];
          name = data['name'];
          email = data['email'];
          role = data['role'];
        }
      }
    } catch (e) {
      throw Exception("Failed to load user data: $e");
    }
  }

  void setUserData({
    required String uid,
    required String name,
    required String email,
    required String role,
  }) {
    this.uid = uid;
    this.name = name;
    this.email = email;
    this.role = role;
  }

  void clearUserData() {
    uid = null;
    name = null;
    email = null;
    role = null;
  }

  bool isAdmin() {
    return role == 'admin';
  }
}
