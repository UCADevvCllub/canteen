import 'package:flutter/material.dart';
import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';
import 'package:canteen/features/debts/presentation/widgets/user_profile_header.dart';
import 'package:canteen/features/debts/presentation/widgets/transaction_item.dart';

/// Страница личного баланса для не-админов
class MyBalancePage extends StatefulWidget {
  const MyBalancePage({Key? key}) : super(key: key);

  @override
  State<MyBalancePage> createState() => _MyBalancePageState();
}

class _MyBalancePageState extends State<MyBalancePage> {
  final DebtsService _debtsService = DebtsService();
  DebtUser? _user;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _debtsService.getCurrentUser();
      
      setState(() {
        _user = user;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Ошибка загрузки: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.grey[600]),
          onPressed: () {},
        ),
        title: Text(
          'My Balance',
          style: TextStyle(
            color: Colors.green[400],
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[400], size: 48),
                      SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.red[400],
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadUserData,
                        child: Text('Повторить'),
                      ),
                    ],
                  ),
                )
              : _user == null
                  ? Center(
                      child: Text(
                        'Данные пользователя не найдены',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadUserData,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            // Профиль пользователя
                            UserProfileHeader(user: _user!),
                            SizedBox(height: 20),
                            // Баланс
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Column(
                                children: [
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    _user!.balance.toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: _user!.balance < 0 ? Colors.red[400] : Colors.green[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            // История транзакций
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'History',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Список транзакций
                            _user!.history.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        'История транзакций пуста',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    itemCount: _user!.history.length,
                                    itemBuilder: (context, index) {
                                      return TransactionItem(
                                        transaction: _user!.history[index],
                                      );
                                    },
                                  ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
    );
  }
}

