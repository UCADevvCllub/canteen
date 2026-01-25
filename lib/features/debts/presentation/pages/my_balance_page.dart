import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/debts/domain/models/debt_user.dart';
import 'package:canteen/features/debts/presentation/widgets/transaction_item.dart';
import 'package:canteen/features/profile/data/my_account_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Страница личного баланса для не-админов
class MyBalancePage extends StatefulWidget {
  const MyBalancePage({Key? key}) : super(key: key);

  @override
  State<MyBalancePage> createState() => _MyBalancePageState();
}

class _MyBalancePageState extends State<MyBalancePage> {
  final DebtsService _debtsService = DebtsService();
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  DebtUser? _user;
  String? _profileImageUrl;
  String? _fullName;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _setupBalanceListener();
  }

  void _setupBalanceListener() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Слушаем изменения баланса в реальном времени
      _firestore.collection('users').doc(currentUser.uid).snapshots().listen((snapshot) {
        if (snapshot.exists && mounted) {
          final data = snapshot.data();
          if (data != null) {
            final newBalance = data['balance'] != null
                ? (data['balance'] is num
                    ? (data['balance'] as num).toDouble()
                    : double.tryParse(data['balance'].toString()) ?? 0.0)
                : 0.0;
            
            setState(() {
              if (_user != null) {
                _user = DebtUser(
                  id: _user!.id,
                  name: _user!.name,
                  fullName: _user!.fullName,
                  phone: _user!.phone,
                  avatar: _user!.avatar,
                  balance: newBalance,
                  history: _user!.history,
                );
              }
            });
          }
        }
      });
    }
  }

  Future<void> _loadUserData() async {
    try {
      final user = await _debtsService.getCurrentUser();
      final userData = await _firebaseService.getUserData();
      
      setState(() {
        _user = user;
        _profileImageUrl = userData?['profileImageUrl'];
        _fullName = userData?['fullName'] ?? user?.fullName ?? user?.name ?? '';
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
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
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
        ),
      );
    }

    if (_user == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Данные пользователя не найдены',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.green[300],
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Balance',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[300],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(ProfileRoute());
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                          ? CachedNetworkImageProvider(_profileImageUrl!)
                          : null,
                      child: _profileImageUrl == null || _profileImageUrl!.isEmpty
                          ? Icon(Icons.person, color: Colors.grey[600], size: 24)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            
            // Greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello, $_fullName',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Balance Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.grey[400],
                  size: 32,
                ),
                const SizedBox(width: 16),
                Text(
                  _user!.balance.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.grey[400],
                  size: 40,
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Divider
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            
            // History Section
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            
            // History List or Empty State
            Expanded(
              child: _user!.history.isEmpty
                  ? Center(
                      child: Text(
                        'Now this page is empty',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[400],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadUserData,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _user!.history.length,
                        itemBuilder: (context, index) {
                          return TransactionItem(
                            transaction: _user!.history[index],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

