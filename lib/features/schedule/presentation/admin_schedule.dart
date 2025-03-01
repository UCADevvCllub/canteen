import 'package:canteen/presentation/pages/schedule/helpers/schedule_dialogs.dart';
import 'package:canteen/presentation/pages/schedule/widgets/schedule_calendar.dart';
import 'package:canteen/presentation/pages/schedule/widgets/status_button.dart';
import 'package:flutter/material.dart';

class AdminSchedulePage extends StatefulWidget {
  const AdminSchedulePage({super.key});

  @override
  State<AdminSchedulePage> createState() => _AdminSchedulePageState();
}

class _AdminSchedulePageState extends State<AdminSchedulePage>
    with ScheduleDialogs {
  String _noteText = "Add note";
  final TextEditingController _noteController = TextEditingController();

  String _statusText = "Open";

  bool _isExpanded = false; // Состояние для управления видимостью кнопок

  @override
  void initState() {
    super.initState();
    _noteController.text = _noteText;
  }

  @override
  Widget build(BuildContext context) {
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
                  StatusButton(
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
                  StatusButton(
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
                showEditNoteDialog(
                  context: context,
                  controller: _noteController,
                  onSaved: () {
                    setState(() {
                      _noteText = _noteController.text;
                    });
                  },
                );
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
            ScheduleCalendar(
              onSaved: () {
                setState(() {
                  // schedule['date'] = dateController.text;
                  // schedule['open'] = openController.text;
                  // schedule['break'] = breakController.text;
                  // schedule['closed'] = closedController.text;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
