import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/layout/navigation_bar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final List<Map<String, String>> weeklySchedule = [
    {"day": "Monday", "date": "October 14, 2024"},
    {"day": "Tuesday", "date": "October 15, 2024"},
    {"day": "Wednesday", "date": "October 16, 2024"},
    {"day": "Today: Thursday", "date": "October 17, 2024"},
    {"day": "Friday", "date": "October 18, 2024"},
    {"day": "Saturday", "date": "October 19, 2024"},
    {"day": "Sunday", "date": "October 20, 2024"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green ,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'OPEN',
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
      ],
    );
  }

  Widget _buildScheduleCard(String day, String date) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Название дня недели (вверху по центру)
            Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: day.startsWith('Today') ? Colors.black : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16), // Отступ между заголовком и нижней частью
            // Нижняя часть: дата слева и время справа (или "Days off")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Дата слева
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Проверка для субботы и воскресенья
                day == "Saturday" || day == "Sunday"
                    ? Text(
                  'Days off', // Текст для выходных
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTimeDetail('Open', '12:00-21:00', Colors.black),
                    _buildTimeDetail('Break', '13:00-14:00', Colors.black),
                    _buildTimeDetail('Closed', '21:00-12:00', Colors.black),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDetail(String label, String time, Color color) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
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
}