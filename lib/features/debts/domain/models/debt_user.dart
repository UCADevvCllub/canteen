import 'package:canteen/features/debts/domain/models/transaction.dart';

/// Модель пользователя с долгами
class DebtUser {
  final String id;
  final String name;
  final String? fullName;
  final String? phone;
  final String? avatar;
  final double balance;
  final List<Transaction> history;

  DebtUser({
    required this.id,
    required this.name,
    this.fullName,
    this.phone,
    this.avatar,
    required this.balance,
    this.history = const [],
  });

  /// Создает DebtUser из данных Firestore
  factory DebtUser.fromFirestore(Map<String, dynamic> data, String id) {
    final name = data['name']?.toString() ?? '';
    final fullName = data['fullName']?.toString();
    final phone = data['phoneNumber']?.toString() ?? data['phone']?.toString();
    final avatar = data['photo_url']?.toString() ?? 
                   data['photoUrl']?.toString() ?? 
                   data['avatar']?.toString();
    
    double balance = 0.0;
    if (data['balance'] != null) {
      if (data['balance'] is num) {
        balance = (data['balance'] as num).toDouble();
      } else if (data['balance'] is String) {
        balance = double.tryParse(data['balance']) ?? 0.0;
      }
    }

    return DebtUser(
      id: id,
      name: name,
      fullName: (fullName != null && fullName.isNotEmpty && fullName != name) ? fullName : null,
      phone: (phone != null && phone.isNotEmpty) ? phone : null,
      avatar: (avatar != null && avatar.isNotEmpty) ? avatar : null,
      balance: balance,
      history: [],
    );
  }
}

