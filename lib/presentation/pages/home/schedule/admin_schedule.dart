import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/layout/navigation_bar.dart';
import 'package:canteen/presentation/widgets/cards/message_bubble_background.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AdminSchedulePage extends StatefulWidget {
  const AdminSchedulePage({super.key});

  @override
  State<AdminSchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<AdminSchedulePage> {
  String _noteText = "Note: Shop will be open only until 19:00 this week";
  TextEditingController _noteController = TextEditingController();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  bool _isExpanded = false;
  String _statusText = "OPEN";

  @override
  void initState() {
    super.initState();
    _noteController.text = _noteText;
    _selectedDay = _focusedDay; // Устанавливаем текущий день как выбранный
  }

  // Функция для генерации расписания на текущую неделю
  List<Map<String, dynamic>> getWeeklySchedule(DateTime startDate) {
    final DateFormat dateFormat = DateFormat('MMMM d, y');
    final DateFormat dayFormat = DateFormat('EEEE');
    List<Map<String, dynamic>> schedule = [];

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String day = dayFormat.format(currentDate);
      if (i == 0) {
        day = "Today: $day";
      }

      schedule.add({
        "day": day,
        "date": dateFormat.format(currentDate),
        "open": "12:00-21:00",
        "break": "13:00-14:00",
        "closed": "21:00-12:00"
      });
    }

    return schedule;
  }

  @override
  Widget build(BuildContext context) {
    final weeklySchedule = getWeeklySchedule(_focusedDay);

    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              constraints: BoxConstraints(maxWidth: 200),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      _statusText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE5F0DC),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isExpanded ? 120 : 0,
            curve: Curves.easeInOut,
            child: Column(
              children: [
                _buildExtraField('BREAK', Colors.orange),
                _buildExtraField('CLOSED', Colors.red),
              ],
            ),
          ),

          SizedBox(height: 10),

          GestureDetector(
            onTap: () {
              _showEditNoteDialog();
            },
            child: BubbleBackground(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _noteText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

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
                      color: Color.lerp(Color(0xFF808080), Colors.white, 0.9) ??
                          Colors.white,
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
                        titleTextStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
                SizedBox(height: 20),

                Column(
                  children: weeklySchedule.map((schedule) {
                    final day = schedule['day']!;
                    final date = schedule['date']!;
                    final open = schedule['open']!;
                    final breakTime = schedule['break']!;
                    final closed = schedule['closed']!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          _showEditTimeDialog(schedule);
                        },
                        child: _buildScheduleCard(
                            day, date, open, breakTime, closed),
                      ),
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

  Widget _buildScheduleCard(String day, String date, String open,
      String breakTime, String closed) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Color.lerp(Color(0xFF808080), Colors.white, 0.9) ?? Colors.white,
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
              day.contains("Saturday") || day.contains("Sunday")
                  ? Text(
                'Days off',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTimeDetail('Open', open, Colors.black),
                  _buildTimeDetail('Break', breakTime, Colors.black),
                  _buildTimeDetail('Closed', closed, Colors.black),
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

  Widget _buildExtraField(String text, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _statusText = text;
          _isExpanded = false;
        });
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 2),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE5F0DC),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: TextField(
            controller: _noteController,
            decoration: InputDecoration(
              hintText: 'Enter your note here',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _noteText = _noteController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTimeDialog(Map<String, dynamic> schedule) {
    TextEditingController openController = TextEditingController(
        text: schedule['open']);
    TextEditingController breakController = TextEditingController(
        text: schedule['break']);
    TextEditingController closedController = TextEditingController(
        text: schedule['closed']);
    TextEditingController dateController = TextEditingController(
        text: schedule['date']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Time for ${schedule['day']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        dateController.text = DateFormat('MMMM d, y').format(
                            pickedDate);
                      }
                    },
                  ),
                ),
              ),
              TextField(
                controller: openController,
                decoration: InputDecoration(
                  labelText: 'Open Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        openController.text = pickedTime.format(context);
                      }
                    },
                  ),
                ),
              ),
              TextField(
                controller: breakController,
                decoration: InputDecoration(
                  labelText: 'Break Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        breakController.text = pickedTime.format(context);
                      }
                    },
                  ),
                ),
              ),
              TextField(
                controller: closedController,
                decoration: InputDecoration(
                  labelText: 'Closed Time',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        closedController.text = pickedTime.format(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  schedule['date'] = dateController.text;
                  schedule['open'] = openController.text;
                  schedule['break'] = breakController.text;
                  schedule['closed'] = closedController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}