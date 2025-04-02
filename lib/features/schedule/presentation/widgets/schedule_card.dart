import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String date;
  final bool isToday;
  final bool isAdmin;
  final Map<String, TimeOfDay> scheduleTimes;
  final VoidCallback onEditTime;

  const ScheduleCard({
    super.key,
    required this.day,
    required this.date,
    required this.isToday,
    required this.isAdmin,
    required this.scheduleTimes,
    required this.onEditTime,
  });

  @override
  Widget build(BuildContext context) {
    final isWeekend = _isWeekend(day);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: isToday ? Colors.green.withOpacity(0.2) : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildDayHeader(isWeekend),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: _dateTextStyle(isToday)),
              if (isWeekend) _buildDaysOff() else _buildTimeDetails(),
            ],
          ),
        ],
      ),
    );
  }

  bool _isWeekend(String day) => day == "Saturday" || day == "Sunday";

  Widget _buildDayHeader(bool isWeekend) {
    if (isAdmin && !isWeekend) {
      return GestureDetector(
        onTap: onEditTime,
        child: Row(
          children: [
            Image.asset(
              'assets/icons/scheduleday.png',
              width: 24,
              height: 24,
            ),
            Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isToday ? Colors.green : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isToday ? Colors.green : Colors.black,
          ),
        ),
      );
    }
  }

  Widget _buildDaysOff() {
    return const Text(
      'Days off',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTimeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildTimeRow('Open', scheduleTimes['open']!),
        _buildTimeRow('Break', scheduleTimes['break']!),
        _buildTimeRow('Closed', scheduleTimes['closed']!),
      ],
    );
  }

  Widget _buildTimeRow(String label, TimeOfDay time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _dateTextStyle(bool isToday) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: isToday ? Colors.green : Colors.black,
    );
  }
}