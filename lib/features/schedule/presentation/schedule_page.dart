
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:canteen/core/widgets/cards/message_bubble_background.dart';
import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/schedule/presentation/widgets/expandable_status_selector.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  String _currentStatus = 'Open';
  String _currentNote = 'Shop will be open only until 19:00 this week';
  late Future<bool> _adminCheckFuture;
  final TextEditingController _noteController = TextEditingController();

  Map<String, Map<String, TimeOfDay>> _scheduleTimes = {
    'Monday': {'open': TimeOfDay(hour: 12, minute: 0), 'break': TimeOfDay(hour: 13, minute: 0), 'closed': TimeOfDay(hour: 21, minute: 0)},
    'Tuesday': {'open': TimeOfDay(hour: 12, minute: 0), 'break': TimeOfDay(hour: 13, minute: 0), 'closed': TimeOfDay(hour: 21, minute: 0)},
    'Wednesday': {'open': TimeOfDay(hour: 12, minute: 0), 'break': TimeOfDay(hour: 13, minute: 0), 'closed': TimeOfDay(hour: 21, minute: 0)},
    'Thursday': {'open': TimeOfDay(hour: 12, minute: 0), 'break': TimeOfDay(hour: 13, minute: 0), 'closed': TimeOfDay(hour: 21, minute: 0)},
    'Friday': {'open': TimeOfDay(hour: 12, minute: 0), 'break': TimeOfDay(hour: 13, minute: 0), 'closed': TimeOfDay(hour: 21, minute: 0)},
    'Saturday': {'open': TimeOfDay(hour: 12, minute: 0), 'break': TimeOfDay(hour: 13, minute: 0), 'closed': TimeOfDay(hour: 21, minute: 0)},
    'Sunday': {'open': TimeOfDay(hour: 12, minute: 0), 'break': TimeOfDay(hour: 13, minute: 0), 'closed': TimeOfDay(hour: 21, minute: 0)},
  };

  @override
  void initState() {
    super.initState();
    _adminCheckFuture = _checkAdminStatus();
    _noteController.text = _currentNote;
  }

  Future<bool> _checkAdminStatus() async {
    final userService = UserService();
    await userService.loadUserData();
    return userService.role?.toLowerCase() == 'admin';
  }

  Future<void> _editNote() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: TextField(
          controller: _noteController,
          decoration: const InputDecoration(hintText: 'Enter new note'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _currentNote = _noteController.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _editTimeDialog(String day) async {
    final currentTimes = _scheduleTimes[day]!;

    final TimeOfDay? newOpen = await showTimePicker(
      context: context,
      initialTime: currentTimes['open']!,
    );
    if (newOpen == null) return;

    final TimeOfDay? newBreak = await showTimePicker(
      context: context,
      initialTime: currentTimes['break']!,
    );
    if (newBreak == null) return;

    final TimeOfDay? newClosed = await showTimePicker(
      context: context,
      initialTime: currentTimes['closed']!,
    );
    if (newClosed == null) return;

    setState(() {
      _scheduleTimes[day] = {
        'open': newOpen,
        'break': newBreak,
        'closed': newClosed,
      };
    });
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            children: [
        Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 2,
                  color: const Color(0xFF84C164),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 18,
                  height: 2,
                  color: const Color(0xFF84C164),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 12,
                  height: 2,
                  color: const Color(0xFF84C164),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Text(
              'Shop Status',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF84C164),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 30),

      FutureBuilder<bool>(
        future: _adminCheckFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text('Error loading user data');
          } else {
            final isAdmin = snapshot.data ?? false;
            return isAdmin
                ? ExpandableStatusSelector(
              currentStatus: _currentStatus,
              onStatusChanged: (newStatus) {
                setState(() => _currentStatus = newStatus);
              },
            )
                : Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 90, vertical: 13),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                _currentStatus,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),

      const SizedBox(height: 25),

      FutureBuilder<bool>(
        future: _adminCheckFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox.shrink();
          }
          final isAdmin = snapshot.data ?? false;

          return isAdmin
              ? GestureDetector(
            onTap: _editNote,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/chatplus.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Add note',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF020202),
                    ),
                  ),
                ],
              ),
            ),
          )
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: BubbleBackground(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "Note: $_currentNote",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),

      const SizedBox(height: 15),

      Container(
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
            onTap: () {
              setState(() {
                _calendarFormat = _calendarFormat == CalendarFormat.month
                    ? CalendarFormat.week
                    : CalendarFormat.month;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
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
                calendarFormat: _calendarFormat,
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
                      DateFormat.MMMM(locale).format(date),
                  titleTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  weekendStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          FutureBuilder<bool>(
            future: _adminCheckFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SizedBox.shrink();
              }
              final isAdmin = snapshot.data ?? false;

              return Column(
                children: weeklySchedule.map((schedule) {
                  final day = schedule['day']!;
                  final date = schedule['date']!;
                  final isToday = isSameDay(
                      _selectedDay, DateFormat('MMMM d, y').parse(date));

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: _buildScheduleCard(day, date, isToday, isAdmin),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    ),
    ],
    ),
    ),
    );
  }

  Widget _buildScheduleCard(String day, String date, bool isToday, bool isAdmin) {
    final isWeekend = day == "Saturday" || day == "Sunday";

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
          if (isAdmin && !isWeekend)
            GestureDetector(
              onTap: () => _editTimeDialog(day),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/scheduleday.png',
                    width: 24, // Уменьшенный размер иконки
                    height: 24,
                  ),
                  Expanded( // Добавляем Expanded для центрирования
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 18, // Увеличили размер текста
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.green : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Center(
              child: Text(
                day,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.green : Colors.black,
                ),
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
                    _buildTimeDetail('Open', day, 'open', Colors.black),
                    _buildTimeDetail('Break', day, 'break', Colors.black),
                    _buildTimeDetail('Closed', day, 'closed', Colors.black),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDetail(String label, String day, String type, Color color) {
    final time = _scheduleTimes[day]![type]!;
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Text(
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }
}