import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String userType; // Staff, Student, Professor
  final String? photoUrl;
  final String phoneNumber;
  final bool? isAdmin;
  //TODO: Add purchase history & debts

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.photoUrl,
    required this.phoneNumber,
    this.isAdmin = false,
  });

  factory User.fromFirebase(DocumentSnapshot snap) {
    Map d = snap.data() as Map<String, dynamic>;
    return User(
      id: d['id'],
      name: d['name'],
      email: d['email'],
      userType: d['user_type'],
      photoUrl: d['photo_url'],
      phoneNumber: d['phone_number'],
      isAdmin: d['is_admin'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'user_type': user.userType,
      'photo_url': user.photoUrl,
      'phoneNumber': user.phoneNumber,
      'isAdmin': user.isAdmin,
    };
  }
}