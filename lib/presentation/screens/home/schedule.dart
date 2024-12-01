import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/navigation_bar.dart'; // Подключаем путь к NavigationBar

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок страницы
            const Text(
              'Your Schedule',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Список расписания
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Пример: 5 задач
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.event,
                        color: Colors.blue,
                      ),
                      title: Text('Task ${index + 1}'),
                      subtitle: const Text('Details about this task'),
                      trailing: const Icon(Icons.check_circle, color: Colors.green),
                    ),
                  );
                },
              ),
            ),

            // Кнопка добавления новой задачи
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Логика для добавления новой задачи
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Навигационная панель
      bottomNavigationBar: AppNavigationBar(
        currentIndex: 2, // Индекс для Schedule Page (например, 2)
        onTap: (int index) {
          // Логика перехода между страницами
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home'); // Переход на HomePage
              break;
            case 1:
              Navigator.pushNamed(context, '/products'); // Переход на ProductsPage
              break;
            case 2:
            // Ничего не делаем, т.к. уже на SchedulePage
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
