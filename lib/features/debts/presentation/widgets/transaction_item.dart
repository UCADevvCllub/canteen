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
    final theme = Theme.of(context);

    final balanceAfterText =
        'Balance ${transaction.balanceAfter.toStringAsFixed(0)}';
    final formattedDate =
        '${transaction.date.day}.${transaction.date.month}.${transaction.date.year.toString().substring(2)} '
        '${transaction.date.hour.toString().padLeft(2, '0')}:'
        '${transaction.date.minute.toString().padLeft(2, '0')} Pm';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
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
              style: theme.textTheme.titleLarge?.copyWith(
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
                balanceAfterText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formattedDate,
                style: theme.textTheme.bodySmall?.copyWith(
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

