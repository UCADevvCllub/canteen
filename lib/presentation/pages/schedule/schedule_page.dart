import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/cards/message_bubble_background.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat =
      CalendarFormat.week; // Начинаем с компактного режима

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Верхний блок с "OPEN"
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.green),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(color: Colors.green),
                child: Text(
                  'OPEN',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE5F0DC),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // Блок для заметок с подключением BubbleBackground
          BubbleBackground(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Note: Shop will be open only until 19:00 this week",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // Основной контейнер с белым фоном и закругленными углами
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Контейнер с календарем
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _calendarFormat = _calendarFormat == CalendarFormat.month
                          ? CalendarFormat.week
                          : CalendarFormat.month;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.lerp(Color(0xFF808080), Colors.white, 0.9)!,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2100, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      calendarFormat: _calendarFormat, // Динамический формат
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        CalendarFormat.week: 'Week',
                      },
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Colors.lightGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.MMMM(locale)
                                .format(date), // Только месяц
                        titleTextStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green, // Название месяца зеленым
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold, // Дни недели жирным
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          // Выходные красным
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Блок с расписанием
                Column(
                  children: weeklySchedule.map((schedule) {
                    final day = schedule['day']!;
                    final date = schedule['date']!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: _buildScheduleCard(day, date),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(String day, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Color.lerp(Color(0xFF808080), Colors.white, 0.9)!,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 5),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              day == "Saturday" || day == "Sunday"
                  ? Text(
                      'Days off',
                      style: TextStyle(
                        fontSize: 16,
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
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
