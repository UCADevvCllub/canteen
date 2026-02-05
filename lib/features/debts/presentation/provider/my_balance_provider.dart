import 'dart:async';

import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';
import 'package:canteen/features/profile/data/my_account_service.dart';
import 'package:flutter/foundation.dart';

class MyBalanceProvider extends ChangeNotifier {
  final DebtsService _debtsService;
  final FirebaseService _firebaseService;

  MyBalanceProvider(
    this._debtsService,
    this._firebaseService,
  ) {
    Future.microtask(_initialize);
  }

  DebtUser? _user;
  String? _profileImageUrl;
  String _fullName = '';
  bool _isLoading = true;
  String? _errorMessage;

  StreamSubscription<double>? _balanceSubscription;

  DebtUser? get user => _user;
  String? get profileImageUrl => _profileImageUrl;
  String get fullName => _fullName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> _initialize() async {
    await loadUserData();
    _listenToBalance();
  }

  Future<void> loadUserData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _debtsService.getCurrentUser();
      final userData = await _firebaseService.getUserData();

      _user = user;
      _profileImageUrl = userData?['profileImageUrl'];
      _fullName = (userData?['fullName'] ?? user?.fullName ?? user?.name ?? '')
          .toString();
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Ошибка загрузки: ${e.toString()}';
      notifyListeners();
    }
  }

  void _listenToBalance() {
    _balanceSubscription?.cancel();

    _balanceSubscription = _debtsService.currentUserBalanceStream().listen(
      (newBalance) {
        if (_user == null) return;
        _user = DebtUser(
          id: _user!.id,
          name: _user!.name,
          fullName: _user!.fullName,
          phone: _user!.phone,
          avatar: _user!.avatar,
          balance: newBalance,
          history: _user!.history,
        );
        notifyListeners();
      },
      onError: (e) {
        // don't hard fail UI: just show error if we still loading
        if (_isLoading) {
          _isLoading = false;
        }
        _errorMessage ??= e.toString();
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _balanceSubscription?.cancel();
    super.dispose();
  }
}

