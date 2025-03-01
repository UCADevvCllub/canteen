import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:canteen/presentation/widgets/cards/message_bubble_background.dart'; // Импортируем ваш BubbleBackground

class AdminSchedulePage extends StatefulWidget {
  const AdminSchedulePage({super.key});

  @override
  State<AdminSchedulePage> createState() => _AdminSchedulePageState();
}

class _AdminSchedulePageState extends State<AdminSchedulePage> {
  String _noteText = "Add note";
  final TextEditingController _noteController = TextEditingController();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  String _statusText = "Open";

  bool _isExpanded = false; // Состояние для управления видимостью кнопок

  @override
  void initState() {
    super.initState();
    _noteController.text = _noteText;
    _selectedDay = _focusedDay;
  }

  List<Map<String, dynamic>> getWeeklySchedule(DateTime startDate) {
    final DateFormat dateFormat = DateFormat('MMMM d, y');
    final DateFormat dayFormat = DateFormat('EEEE');
    List<Map<String, dynamic>> schedule = [];

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String day = dayFormat.format(currentDate);
      if (i == 0) {
        day = "Shop Schedule"; // Заменяем "Today: день недели" на "Shop Schedule"
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header с "Shop Status" и иконкой меню
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Row(
                children: [
                  // Иконка меню с тремя линиями
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 2,
                        color: Color(0xFF84C164),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 18,
                        height: 2,
                        color: Color(0xFF84C164),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 12,
                        height: 2,
                        color: Color(0xFF84C164),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Text(
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

            SizedBox(height: 30),

            // Кнопка "Open"
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded; // Переключаем состояние
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 60),
                padding: EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Image.asset(
                        'assets/icons/linesforschedule.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      _statusText,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Раскрывающиеся кнопки "Break" и "Closed"
            if (_isExpanded) // Показываем, если _isExpanded == true
              Column(
                children: [
                  SizedBox(height: 16),
                  _buildStatusButton(
                    text: "Break",
                    color: Colors.orange,
                    onPressed: () {
                      setState(() {
                        _statusText = "Break";
                        _isExpanded = false; // Скрываем кнопки после выбора
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  _buildStatusButton(
                    text: "Closed",
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _statusText = "Closed";
                        _isExpanded = false; // Скрываем кнопки после выбора
                      });
                    },
                  ),
                ],
              ),

            SizedBox(height: 25),

            // Заметка
            GestureDetector(
              onTap: () {
                _showEditNoteDialog();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Иконка
                        Image.asset(
                          'assets/icons/chatplus.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 8),
                        // Текст
                        Text(
                          _noteText,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Основной контейнер с календарем и расписанием
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
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Календарь
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
                          titleTextStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
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
                  SizedBox(height: 20),

                  // Расписание, начиная с сегодняшнего дня
                  Column(
                    children: weeklySchedule.map((schedule) {
                      final day = schedule['day']!;
                      final date = schedule['date']!;
                      final open = schedule['open']!;
                      final breakTime = schedule['break']!;
                      final closed = schedule['closed']!;
                      final isToday = isSameDay(_selectedDay, DateFormat('MMMM d, y').parse(date));

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: GestureDetector(
                          onTap: () {
                            _showEditTimeDialog(schedule);
                          },
                          child: _buildScheduleCard(day, date, open, breakTime, closed, isToday),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard(String day, String date, String open, String breakTime, String closed, bool isToday) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Один цвет для всех дней (например, светло-серый)
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
          // Название дня недели с иконкой
          Row(
            children: [
              // Иконка (слева в начале)
              Image.asset(
                'assets/icons/scheduleday.png',
                width: 24, // Размер иконки
                height: 24,
              ),
              SizedBox(width: 16), // Расстояние между иконкой и текстом
              // Название дня недели (по центру относительно всей строки)
              Expanded(
                child: Center(
                  child: Text(
                    day == "Shop Schedule" ? "Shop Schedule" : day,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: day == "Shop Schedule" ? FontWeight.bold : FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16), // Отступ между названием дня и датой
          // Дата и время работы
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Дата
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Время работы (если не выходной)
              if (!day.contains("Saturday") && !day.contains("Sunday"))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTimeDetail('Open', open, Colors.black),
                    _buildTimeDetail('Break', breakTime, Colors.black),
                    _buildTimeDetail('Closed', closed, Colors.black),
                  ],
                ),
              // Выходные
              if (day.contains("Saturday") || day.contains("Sunday"))
                Text(
                  'Days off',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
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
    TextEditingController openController =
    TextEditingController(text: schedule['open']);
    TextEditingController breakController =
    TextEditingController(text: schedule['break']);
    TextEditingController closedController =
    TextEditingController(text: schedule['closed']);
    TextEditingController dateController =
    TextEditingController(text: schedule['date']);

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
                        dateController.text =
                            DateFormat('MMMM d, y').format(pickedDate);
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

  Widget _buildStatusButton({required String text, required Color color, required VoidCallback onPressed}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Цвет фона кнопки
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Белый текст
          ),
        ),
      ),
    );
  }
}

