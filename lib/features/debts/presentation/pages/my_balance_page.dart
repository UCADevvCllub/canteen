import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/config/di.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/debts/presentation/widgets/transaction_item.dart';
import 'package:canteen/features/profile/data/my_account_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:canteen/features/debts/presentation/provider/my_balance_provider.dart';
import 'package:provider/provider.dart';

/// Страница личного баланса для не-админов
class MyBalancePage extends StatelessWidget {
  const MyBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyBalanceProvider(
        locator<DebtsService>(),
        FirebaseService(),
      ),
      child: Consumer<MyBalanceProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const _MyBalanceLoading();
          }

          if (provider.errorMessage != null) {
            return _MyBalanceError(
              message: provider.errorMessage!,
              onRetry: provider.loadUserData,
            );
          }

          if (provider.user == null) {
            return const _MyBalanceEmptyUser();
          }

          return _MyBalanceContent(
            userBalanceText: provider.user!.balance.toStringAsFixed(0),
            history: provider.user!.history,
            fullName: provider.fullName,
            profileImageUrl: provider.profileImageUrl,
            onRefresh: provider.loadUserData,
          );
        },
      ),
    );
  }
}

class _MyBalanceLoading extends StatelessWidget {
  const _MyBalanceLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _MyBalanceError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _MyBalanceError({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.red[400],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyBalanceEmptyUser extends StatelessWidget {
  const _MyBalanceEmptyUser();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'Данные пользователя не найдены',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}

class _MyBalanceContent extends StatelessWidget {
  final String userBalanceText;
  final List history;
  final String fullName;
  final String? profileImageUrl;
  final Future<void> Function() onRefresh;

  const _MyBalanceContent({
    required this.userBalanceText,
    required this.history,
    required this.fullName,
    required this.profileImageUrl,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _MyBalanceHeader(profileImageUrl: profileImageUrl),
            _MyBalanceGreeting(fullName: fullName),
            const SizedBox(height: 20),
            _MyBalanceAmount(balanceText: userBalanceText),
            const SizedBox(height: 40),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            const _MyBalanceHistoryTitle(),
            Expanded(
              child: history.isEmpty
                  ? const _MyBalanceEmptyHistory()
                  : RefreshIndicator(
                      onRefresh: onRefresh,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          return TransactionItem(
                            transaction: history[index],
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

class _MyBalanceHeader extends StatelessWidget {
  final String? profileImageUrl;

  const _MyBalanceHeader({required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
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
                style: theme.textTheme.headlineMedium?.copyWith(
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
              backgroundImage:
                  profileImageUrl != null && profileImageUrl!.isNotEmpty
                      ? CachedNetworkImageProvider(profileImageUrl!)
                      : null,
              child: profileImageUrl == null || profileImageUrl!.isEmpty
                  ? Icon(Icons.person, color: Colors.grey[600], size: 24)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyBalanceGreeting extends StatelessWidget {
  final String fullName;

  const _MyBalanceGreeting({required this.fullName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Hello, $fullName',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

class _MyBalanceAmount extends StatelessWidget {
  final String balanceText;

  const _MyBalanceAmount({required this.balanceText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline,
          color: Colors.grey[400],
          size: 32,
        ),
        const SizedBox(width: 16),
        Text(
          balanceText,
          style: theme.textTheme.displayLarge?.copyWith(
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
    );
  }
}

class _MyBalanceHistoryTitle extends StatelessWidget {
  const _MyBalanceHistoryTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'History',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MyBalanceEmptyHistory extends StatelessWidget {
  const _MyBalanceEmptyHistory();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Now this page is empty',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: Colors.grey[400],
        ),
      ),
    );
  }
}

