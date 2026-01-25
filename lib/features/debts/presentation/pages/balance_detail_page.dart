import 'package:flutter/material.dart';
import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';
import 'package:canteen/features/debts/presentation/widgets/balance_editor.dart';
import 'package:canteen/features/debts/presentation/widgets/user_profile_header.dart';
import 'package:canteen/features/debts/presentation/widgets/transaction_item.dart';

/// Страница детального баланса пользователя
class BalanceDetailPage extends StatefulWidget {
  final DebtUser user;

  const BalanceDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  State<BalanceDetailPage> createState() => _BalanceDetailPageState();
}

class _BalanceDetailPageState extends State<BalanceDetailPage> {
  final DebtsService _debtsService = DebtsService();
  late double _currentBalance;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _currentBalance = widget.user.balance;
  }

  Future<void> _updateBalance(double newBalance) async {
    setState(() {
      _isUpdating = true;
    });

    try {
      await _debtsService.updateUserBalance(widget.user.id, newBalance);

      setState(() {
        _currentBalance = newBalance;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Баланс обновлен'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green[400]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Balance',
          style: TextStyle(
            color: Colors.green[400],
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Профиль пользователя
          UserProfileHeader(user: widget.user),
          SizedBox(height: 20),
          // Баланс с кнопками
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: BalanceEditor(
              initialBalance: _currentBalance,
              onBalanceChanged: _updateBalance,
              isUpdating: _isUpdating,
            ),
          ),
          SizedBox(height: 20),
          // История транзакций
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'History',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(height: 10),
          // Список транзакций
          Expanded(
            child: widget.user.history.isEmpty
                ? Center(
                    child: Text(
                      'История транзакций пуста',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.user.history.length,
                    itemBuilder: (context, index) {
                      return TransactionItem(
                        transaction: widget.user.history[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

