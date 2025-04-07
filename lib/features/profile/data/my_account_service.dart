import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Получение текущего пользователя
  User? get currentUser => _auth.currentUser;

  // Получение данных пользователя из Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return doc.data();
        }
      }
      return null;
    } catch (e) {
      print('Ошибка при получении данных пользователя: $e');
      return null;
    }
  }


  Future<bool> updateUserData({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String language,
  }) async {
    try {
      final user = currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
          'language': language,
          'updatedAt': FieldValue.serverTimestamp(),
        });


        if (user.email != email) {
          await user.updateEmail(email);
        }

        return true;
      }
      return false;
    } catch (e) {
      print('Ошибка при обновлении данных пользователя: $e');
      return false;
    }
  }


  Future<String?> uploadProfileImage(File image) async {
    try {
      final user = currentUser;
      if (user != null) {
        // Создаем путь для изображения
        final Reference storageRef = _storage.ref().child('profile_images/${user.uid}');

        // Загружаем изображение
        final UploadTask uploadTask = storageRef.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask;

        // Получаем URL загруженного изображения
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Обновляем URL изображения в Firestore
        await _firestore.collection('users').doc(user.uid).update({
          'profileImageUrl': downloadUrl,
        });

        return downloadUrl;
      }
      return null;
    } catch (e) {
      print('Ошибка при загрузке изображения: $e');
      return null;
    }
  }

  // Удаление аккаунта пользователя
  Future<bool> deleteAccount() async {
    try {
      final user = currentUser;
      if (user != null) {
        // Удаляем данные пользователя из Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Удаляем изображение профиля из Storage, если оно существует
        try {
          await _storage.ref().child('profile_images/${user.uid}').delete();
        } catch (e) {
          // Если изображения нет, игнорируем ошибку
          print('Изображение профиля не найдено или уже удалено');
        }

        // Удаляем пользователя из Authentication
        await user.delete();

        return true;
      }
      return false;
    } catch (e) {
      print('Ошибка при удалении аккаунта: $e');
      return false;
    }
  }
}