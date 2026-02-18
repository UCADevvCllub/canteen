import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';

class DebtsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String usersCollection = 'users';

  Stream<double> currentUserBalanceStream() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Stream.error(Exception('Пользователь не авторизован'));
    }

    return _firestore
        .collection(usersCollection)
        .doc(currentUser.uid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data == null) return 0.0;

      final raw = data['balance'];
      if (raw == null) return 0.0;
      if (raw is num) return raw.toDouble();
      return double.tryParse(raw.toString()) ?? 0.0;
    });
  }

  /// Получить список всех пользователей (кроме текущего)
  Future<List<DebtUser>> getAllUsers() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('Пользователь не авторизован');
    }

    final snapshot = await _firestore.collection(usersCollection).get();
    
    final List<DebtUser> users = [];
    
    for (var doc in snapshot.docs) {
      final userId = doc.id;
      final userUid = doc.data()['uid']?.toString() ?? userId;
      
      // Пропускаем текущего пользователя
      if (userId == currentUser.uid || userUid == currentUser.uid) {
        continue;
      }

      final name = doc.data()['name']?.toString() ?? '';
      
      // Пропускаем пользователей без имени
      if (name.isEmpty) {
        continue;
      }
      
      users.add(DebtUser.fromFirestore(doc.data(), userId));
    }

    // Сортируем по алфавиту по имени
    users.sort((a, b) => a.name.compareTo(b.name));

    return users;
  }

  /// Обновить баланс пользователя
  Future<void> updateUserBalance(String userId, double newBalance) async {
    await _firestore.collection(usersCollection).doc(userId).update({
      'balance': newBalance,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Получить данные пользователя по ID
  Future<DebtUser?> getUserById(String userId) async {
    final doc = await _firestore.collection(usersCollection).doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return DebtUser.fromFirestore(doc.data()!, doc.id);
    }
    return null;
  }

  /// Получить данные текущего пользователя
  Future<DebtUser?> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return null;
    }
    return getUserById(currentUser.uid);
  }
}

