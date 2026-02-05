import 'package:flutter/material.dart';
import 'package:canteen/core/config/di.dart';
import 'package:canteen/features/debts/presentation/widgets/search_bar.dart';
import 'package:canteen/features/debts/presentation/widgets/user_list_item.dart';
import 'package:canteen/features/debts/presentation/pages/my_balance_page.dart';
import 'package:canteen/features/debts/presentation/provider/debts_provider.dart';
import 'package:provider/provider.dart';

/// Главная страница со списком долгов (для админов) или личным балансом (для пользователей)
class DebtsPage extends StatelessWidget {
  const DebtsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DebtsProvider(locator(), locator()),
      child: Consumer<DebtsProvider>(
        builder: (context, debtsProvider, child) {
          // Если проверяем роль - показываем загрузку
          if (debtsProvider.isCheckingRole) {
            return Scaffold(
              backgroundColor: Colors.grey[50],
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // Если не админ - показываем страницу личного баланса
          if (!debtsProvider.isAdmin) {
            return const MyBalancePage();
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
                  onChanged: debtsProvider.setSearchQuery,
                ),
                // Заголовок "Debts"
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
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
                  child: debtsProvider.isLoadingUsers
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : debtsProvider.errorMessage != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red[400],
                                    size: 48,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    debtsProvider.errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red[400],
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: debtsProvider.loadUsers,
                                    child: const Text('Повторить'),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: debtsProvider.loadUsers,
                              child: debtsProvider.filteredUsers.isEmpty
                                  ? SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        alignment: Alignment.center,
                                        child: Text(
                                          debtsProvider.searchQuery.isEmpty
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
                                      itemCount:
                                          debtsProvider.filteredUsers.length,
                                      itemBuilder: (context, index) {
                                        return UserListItem(
                                          user: debtsProvider.filteredUsers[
                                              index],
                                        );
                                      },
                                    ),
                            ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

