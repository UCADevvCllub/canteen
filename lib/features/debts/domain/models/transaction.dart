import 'package:cloud_firestore/cloud_firestore.dart';

/// Модель транзакции
class Transaction {
  final double amount;
  final DateTime date;
  final double balanceAfter;

  Transaction({
    required this.amount,
    required this.date,
    required this.balanceAfter,
  });

  /// Создает Transaction из данных Firestore
  factory Transaction.fromFirestore(Map<String, dynamic> data) {
    return Transaction(
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      balanceAfter: (data['balanceAfter'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

