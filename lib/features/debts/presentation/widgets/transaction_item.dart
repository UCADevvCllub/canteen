import 'package:flutter/material.dart';
import 'package:canteen/features/debts/domain/models/transaction.dart';

/// Виджет элемента истории транзакций
class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isNegative = transaction.amount < 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Сумма транзакции
          Expanded(
            child: Text(
              transaction.amount > 0
                  ? '+${transaction.amount.toStringAsFixed(0)}'
                  : transaction.amount.toStringAsFixed(0),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isNegative ? Colors.red[400] : Colors.green[400],
              ),
            ),
          ),
          // Баланс после и дата
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Balance ${transaction.balanceAfter.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${transaction.date.day}.${transaction.date.month}.${transaction.date.year.toString().substring(2)} ${transaction.date.hour.toString().padLeft(2, '0')}:${transaction.date.minute.toString().padLeft(2, '0')} Pm',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

