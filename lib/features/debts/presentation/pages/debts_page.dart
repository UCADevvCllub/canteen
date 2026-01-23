import 'package:flutter/material.dart';
import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';
import 'package:canteen/features/debts/presentation/widgets/search_bar.dart';
import 'package:canteen/features/debts/presentation/widgets/user_list_item.dart';
import 'package:canteen/features/debts/presentation/pages/my_balance_page.dart';

/// Главная страница со списком долгов (для админов) или личным балансом (для пользователей)
class DebtsPage extends StatefulWidget {
  const DebtsPage({Key? key}) : super(key: key);

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  final DebtsService _debtsService = DebtsService();
  final UserService _userService = UserService();
  
  bool _isAdmin = false;
  bool _isCheckingRole = true;
  List<DebtUser> _users = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    try {
      // Загружаем данные пользователя
      await _userService.loadUserData();
      
      setState(() {
        _isAdmin = _userService.isAdmin();
        _isCheckingRole = false;
      });

      // Если админ - загружаем список пользователей
      if (_isAdmin) {
        _loadUsers();
      } else {
        // Если не админ - просто показываем, что загрузка завершена
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isCheckingRole = false;
        _isLoading = false;
        _errorMessage = 'Ошибка проверки роли: ${e.toString()}';
      });
    }
  }

  Future<void> _loadUsers() async {
    try {
      final users = await _debtsService.getAllUsers();
      
      setState(() {
        _users = users;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().contains('не авторизован')
            ? 'Вы не авторизованы. Пожалуйста, войдите в систему.'
            : 'Ошибка загрузки: ${e.toString()}';
      });
    }
  }

  List<DebtUser> get _filteredUsers {
    if (_searchQuery.isEmpty) {
      return _users;
    }
    return _users.where((user) {
      final name = user.name.toLowerCase();
      final fullName = (user.fullName ?? '').toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || fullName.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Если проверяем роль - показываем загрузку
    if (_isCheckingRole) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Если не админ - показываем страницу личного баланса
    if (!_isAdmin) {
      return MyBalancePage();
    }

    // Если админ - показываем список всех пользователей
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
          // Поиск
          SearchBarWidget(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          // Заголовок "Debts"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Debts',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Список должников
          Expanded(
            child: _isLoading
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
                              onPressed: _loadUsers,
                              child: Text('Повторить'),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadUsers,
                        child: _filteredUsers.isEmpty
                            ? SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  alignment: Alignment.center,
                                  child: Text(
                                    _searchQuery.isEmpty
                                        ? 'Нет пользователей'
                                        : 'Пользователи не найдены',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _filteredUsers.length,
                                itemBuilder: (context, index) {
                                  return UserListItem(
                                    user: _filteredUsers[index],
                                  );
                                },
                              ),
                      ),
          ),
        ],
      ),
    );
  }
}

