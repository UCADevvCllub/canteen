import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyScheduleList extends StatelessWidget {
  final DateTime selectedDay;
  final List<Map<String, String>> scheduleData;

  const WeeklyScheduleList({
    super.key,
    required this.selectedDay,
    required this.scheduleData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: scheduleData.map((schedule) {
        final day = schedule['day']!;
        final date = schedule['date']!;
        final isToday = isSameDay(selectedDay, DateFormat('MMMM d, y').parse(date));
        final isWeekend = day == "Saturday" || day == "Sunday";

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: ScheduleDayCard(
            day: day,
            date: date,
            isToday: isToday,
            isWeekend: isWeekend,
          ),
        );
      }).toList(),
    );
  }
}

class ScheduleDayCard extends StatelessWidget {
  final String day;
  final String date;
  final bool isToday;
  final bool isWeekend;

  const ScheduleDayCard({
    super.key,
    required this.day,
    required this.date,
    required this.isToday,
    required this.isWeekend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: isToday ? Colors.green.withOpacity(0.2) : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isToday ? Colors.green : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.green : Colors.black,
                ),
              ),
              if (isWeekend)
                const Text(
                  'Days off',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTimeDetail('Open', '12:00–21:00'),
                    _buildTimeDetail('Break', '13:00–14:00'),
                    _buildTimeDetail('Closed', '21:00–12:00'),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDetail(String label, String time) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

bool isSameDay(DateTime dateA, DateTime dateB) {
  return dateA.year == dateB.year &&
      dateA.month == dateB.month &&
      dateA.day == dateB.day;
}