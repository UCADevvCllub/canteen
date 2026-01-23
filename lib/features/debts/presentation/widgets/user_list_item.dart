import 'package:flutter/material.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';
import 'package:canteen/features/debts/presentation/pages/balance_detail_page.dart';

/// Виджет элемента списка пользователей
class UserListItem extends StatelessWidget {
  final DebtUser user;

  const UserListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          user.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Text(
          user.balance.toStringAsFixed(0),
          style: TextStyle(
            color: user.balance < 0 ? Colors.red[400] : Colors.green[400],
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BalanceDetailPage(user: user),
            ),
          );
        },
      ),
    );
  }
}

