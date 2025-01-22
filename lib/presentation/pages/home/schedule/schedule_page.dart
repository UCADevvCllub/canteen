import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/layout/navigation_bar.dart';
import 'package:canteen/presentation/widgets/cards/message_bubble_background.dart';


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
    return SingleChildScrollView(
      child: Column(
        children: [
          // Верхний блок с "OPEN"
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
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

          // Блок для заметок с подключением MessageBackground
          BubbleBackground(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Note: Shop will be open only until 19:00 this week",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              ),
            ),
          ),

          SizedBox(height: 10), // Отступ

          // Основной контент со списком расписания
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: weeklySchedule.map((schedule) {
                final day = schedule['day']!;
                final date = schedule['date']!;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildScheduleCard(day, date),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(String day, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Светло-серый фон
        borderRadius: BorderRadius.circular(15), // Скругленные углы
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Легкая тень
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              day == "Saturday" || day == "Sunday"
                  ? Text(
                'Days off',
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

