import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/navigation_bar.dart'; // Подключаем путь к NavigationBar

import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String status = ''; // Статус ("Open", "Break", "Closed")

  final List<Map<String, String>> weeklySchedule = [
    {"day": "Monday", "date": "October 14, 2024"},
    {"day": "Tuesday", "date": "October 15, 2024"},
    {"day": "Wednesday", "date": "October 16, 2024"},
    {"day": "Today: Thursday", "date": "October 17, 2024"},
    {"day": "Friday", "date": "October 18, 2024"},
    {"day": "Saturday", "date": "October 19, 2024"},
    {"day": "Sunday", "date": "October 20, 2024"},
  ];

  Future<void> _onRefresh() async {
    // Имитация обновления данных (2 секунды)
    await Future.delayed(Duration(seconds: 2));

    // Меняем статус (цикл между Open, Break и Closed)
    setState(() {
      if (status == '' || status == 'Closed') {
        status = 'Open';
      } else if (status == 'Open') {
        status = 'Break';
      } else if (status == 'Break') {
        status = 'Closed';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status of Shop'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Column(
          children: [
            if (status.isNotEmpty)
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '• Schedule •',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: weeklySchedule.length,
                itemBuilder: (context, index) {
                  final day = weeklySchedule[index]['day']!;
                  final date = weeklySchedule[index]['date']!;
                  return _buildScheduleCard(day, date);
                },
              ),
            ),
            BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/recommendation.png',
                    width: 24,
                    height: 24,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz),
                  label: '',
                ),
              ],
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(String day, String date) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: day.startsWith('Today') ? Colors.black : Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              date,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeDetail('Open', '12:00-21:00', Colors.orange),
                _buildTimeDetail('Break', '13:00-14:00', Colors.black),
                _buildTimeDetail('Closed', '21:00-12:00', Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDetail(String label, String time, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case 'Open':
        return Colors.orange;
      case 'Break':
        return Colors.brown;
      case 'Closed':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }
}
