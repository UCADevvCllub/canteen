import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:canteen/features/schedule/presentation/widgets/schedule_card.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleList extends StatelessWidget {
  final bool isAdmin;
  final DateTime? selectedDay;
  final Map<String, Map<String, TimeOfDay>> scheduleTimes;
  final Function(String) onEditTime;

  const ScheduleList({
    super.key,
    required this.isAdmin,
    required this.selectedDay,
    required this.scheduleTimes,
    required this.onEditTime,
  });

  List<Map<String, String>> get weeklySchedule {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = now.add(Duration(days: index));
      return {
        "day": DateFormat('EEEE').format(day),
        "date": DateFormat('MMMM d, y').format(day),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weeklySchedule.map((schedule) {
        final day = schedule['day']!;
        final date = schedule['date']!;
        final isToday = isSameDay(selectedDay, DateFormat('MMMM d, y').parse(date));

        return ScheduleCard(
          key: ValueKey(day),
          day: day,
          date: date,
          isToday: isToday,
          isAdmin: isAdmin,
          scheduleTimes: scheduleTimes[day]!,
          onEditTime: () => onEditTime(day),
        );
      }).toList(),
    );
  }
}