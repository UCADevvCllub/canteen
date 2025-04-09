import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:canteen/features/schedule/presentation/widgets/custom_calendar.dart';
import 'package:canteen/features/schedule/presentation/widgets/layout/schedule_list.dart';

class CalendarSection extends StatelessWidget {
  final bool isAdmin;
  final CalendarFormat calendarFormat;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<String, Map<String, TimeOfDay>> scheduleTimes;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(String) onEditTime;

  const CalendarSection({
    super.key,
    required this.isAdmin,
    required this.calendarFormat,
    required this.focusedDay,
    required this.selectedDay,
    required this.scheduleTimes,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onEditTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onFormatChanged(
              calendarFormat == CalendarFormat.month
                  ? CalendarFormat.week
                  : CalendarFormat.month,
            ),
            child: CustomCalendar(
              calendarFormat: calendarFormat,
              focusedDay: focusedDay,
              selectedDay: selectedDay,
              onDaySelected: onDaySelected,
              onFormatChanged: onFormatChanged,
            ),
          ),
          const SizedBox(height: 20),
          ScheduleList(
            selectedDay: selectedDay,
          ),
        ],
      ),
    );
  }
}
