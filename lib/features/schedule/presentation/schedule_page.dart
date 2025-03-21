import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:canteen/core/widgets/cards/message_bubble_background.dart'; // Импортируем ваш BubbleBackground
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  String _status = "Open";
  String _note = "Add note";
  Map<String, Map<String, String>> _weekSchedule = {};

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now(); // Сегодняшняя дата
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  Future<void> _loadScheduleFromFirebase() async {
    try {
      // Получаем документ с расписанием
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('admin_schedule').doc('shop_status').get();

      if (snapshot.exists) {
        setState(() {
          _status = snapshot.data()?['status'] ?? "Open";
          _note = snapshot.data()?['note'] ?? "Add note";
          _weekSchedule = Map<String, Map<String, String>>.from(
            (snapshot.data()?['week_schedule'] ?? {}).map(
                  (day, schedule) => MapEntry(
                day,
                Map<String, String>.from(schedule),
              ),
            ),
          );
        });
      }
    } catch (e) {
      print("Ошибка загрузки данных: $e");
    }
  }

  // Генерация расписания, начиная с сегодняшнего дня
  List<Map<String, String>> get weeklySchedule {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = now.add(Duration(days: index));
      return {
        "day": DateFormat('EEEE').format(day), // Название дня недели
        "date": DateFormat('MMMM d, y').format(day), // Дата
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Белый фон всей страницы
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
                        width: 24, // Длина верхней линии
                        height: 2,
                        color: Color(0xFF84C164),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 18, // Длина средней линии
                        height: 2,
                        color: Color(0xFF84C164),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 12, // Длина нижней линии
                        height: 2,
                        color: Color(0xFF84C164),
                      ),
                    ],
                  ),
                  SizedBox(width: 10), // Отступ между иконкой и текстом
                  Text(
                    'Shop Status',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF84C164), // Зеленый цвет текста
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30), // Увеличиваем расстояние между заголовком и кнопкой

            // Блок с "Open", который теперь динамический
            Container(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 13),
              decoration: BoxDecoration(
                color: _status == "Open"
                    ? Colors.green
                    : _status == "Break"
                    ? Colors.orange
                    : Colors.red, // Цвет зависит от статуса
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                _status, // Теперь статус загружается из Firestore
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 25), // Отступ между "Open" и заметкой

            // Заметка с BubbleBackground (теперь из Firestore)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BubbleBackground(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    _note, // Теперь заметка загружается из Firestore
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20), // Отступ перед расписанием

            // Отображение расписания по дням недели
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _weekSchedule.length,
              itemBuilder: (context, index) {
                String day = _weekSchedule.keys.elementAt(index);
                Map<String, dynamic> schedule = _weekSchedule[day];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${schedule['open']} - ${schedule['break']} - ${schedule['closed']}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox(height: 15), // Отступ между заметкой и календарем

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
                    offset: Offset(0, -5), // Тень направлена вверх
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Календарь
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _calendarFormat =
                            _calendarFormat == CalendarFormat.month
                                ? CalendarFormat.week
                                : CalendarFormat.month;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Светло-серый фон
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
                      final isToday = isSameDay(
                          _selectedDay, DateFormat('MMMM d, y').parse(date));

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: _buildScheduleCard(day, date, isToday),
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

  Widget _buildScheduleCard(String day, String date, bool isToday) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: isToday
            ? Colors.green.withOpacity(0.2)
            : Colors.grey[200], // Подсветка сегодняшнего дня
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
                color: isToday
                    ? Colors.green
                    : Colors.black, // Зеленый текст для сегодняшнего дня
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
                  color: isToday
                      ? Colors.green
                      : Colors.black, // Зеленый текст для сегодняшнего дня
                ),
              ),
              day == "Saturday" || day == "Sunday"
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
                        _buildTimeDetail('Open', '12:00–21:00', Colors.black),
                        _buildTimeDetail('Break', '13:00–14:00', Colors.black),
                        _buildTimeDetail('Closed', '21:00–12:00', Colors.black),
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
