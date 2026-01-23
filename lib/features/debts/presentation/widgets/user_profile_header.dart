import 'package:flutter/material.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';

/// Виджет заголовка профиля пользователя
class UserProfileHeader extends StatelessWidget {
  final DebtUser user;

  const UserProfileHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          // Аватар
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            backgroundImage: user.avatar != null
                ? NetworkImage(user.avatar!)
                : null,
            child: user.avatar == null
                ? Icon(Icons.person, size: 50, color: Colors.grey[600])
                : null,
          ),
          SizedBox(height: 12),
          // Имя
          Text(
            user.fullName ?? user.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 4),
          // Статус
          Text(
            'Student',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          if (user.phone != null) ...[
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 16, color: Colors.grey[400]),
                SizedBox(width: 4),
                Text(
                  user.phone!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

