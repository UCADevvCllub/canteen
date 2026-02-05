import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';
import 'package:flutter/foundation.dart';

class DebtsProvider extends ChangeNotifier {
  final DebtsService _debtsService;
  final UserService _userService;

  DebtsProvider(this._debtsService, this._userService) {
    Future.microtask(_initialize);
  }

  bool _isAdmin = false;
  bool _isCheckingRole = true;

  List<DebtUser> _users = [];
  bool _isLoadingUsers = true;

  String _searchQuery = '';
  String? _errorMessage;

  bool get isAdmin => _isAdmin;
  bool get isCheckingRole => _isCheckingRole;
  bool get isLoadingUsers => _isLoadingUsers;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;

  List<DebtUser> get users => List.unmodifiable(_users);

  List<DebtUser> get filteredUsers {
    if (_searchQuery.isEmpty) return users;

    final query = _searchQuery.toLowerCase();
    return _users.where((user) {
      final name = user.name.toLowerCase();
      final fullName = (user.fullName ?? '').toLowerCase();
      return name.contains(query) || fullName.contains(query);
    }).toList();
  }

  Future<void> _initialize() async {
    await checkUserRoleAndMaybeLoadUsers();
  }

  Future<void> checkUserRoleAndMaybeLoadUsers() async {
    _isCheckingRole = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _userService.loadUserData();
      _isAdmin = _userService.isAdmin();
      _isCheckingRole = false;
      notifyListeners();

      if (_isAdmin) {
        await loadUsers();
      } else {
        _isLoadingUsers = false;
        notifyListeners();
      }
    } catch (e) {
      _isCheckingRole = false;
      _isLoadingUsers = false;
      _errorMessage = 'Ошибка проверки роли: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> loadUsers() async {
    _isLoadingUsers = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final users = await _debtsService.getAllUsers();
      _users = users;
      _isLoadingUsers = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _isLoadingUsers = false;
      final message = e.toString();
      _errorMessage = message.contains('не авторизован')
          ? 'Вы не авторизованы. Пожалуйста, войдите в систему.'
          : 'Ошибка загрузки: $message';
      notifyListeners();
    }
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}

