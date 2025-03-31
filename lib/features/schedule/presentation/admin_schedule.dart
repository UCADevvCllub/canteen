import 'package:canteen/features/schedule/presentation/helpers/schedule_dialogs.dart';
import 'package:canteen/features/schedule/presentation/widgets/schedule_calendar.dart';
import 'package:canteen/features/schedule/presentation/widgets/schedule_header.dart';
import 'package:canteen/features/schedule/presentation/widgets/expandable_status_selector.dart';
import 'package:canteen/features/schedule/presentation/widgets/note_section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:canteen/features/schedule/presentation/widgets/weekly_schedule_list.dart';

class AdminSchedulePage extends StatefulWidget {
  const AdminSchedulePage({super.key});

  @override
  State<AdminSchedulePage> createState() => _AdminSchedulePageState();
}

class _AdminSchedulePageState extends State<AdminSchedulePage> {
  String _noteText = "Add note";
  final TextEditingController _noteController = TextEditingController();
  String _statusText = "Open";
  DateTime _selectedDay = DateTime.now();

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
            const ScheduleHeader(),
            const SizedBox(height: 30),
            ExpandableStatusSelector(
              currentStatus: _statusText,
              onStatusChanged: (newStatus) => setState(() => _statusText = newStatus),
            ),
            const SizedBox(height: 25),
            NoteSection(
              noteText: _noteText,
              controller: _noteController,
              onNoteChanged: (newNote) => setState(() => _noteText = newNote),
            ),
            const SizedBox(height: 15),
            ScheduleCalendar(
              weekSchedule: {},
              onSave: () => setState(() {}),
            ),
            const SizedBox(height: 20),
            WeeklyScheduleList(
              selectedDay: _selectedDay,
              scheduleData: weeklySchedule,
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:canteen/features/schedule/presentation/helpers/schedule_dialogs.dart';
// import 'package:canteen/features/schedule/presentation/widgets/schedule_calendar.dart';
// import 'package:canteen/features/schedule/presentation/widgets/status_button.dart';
// import 'package:flutter/material.dart';
//
// class AdminSchedulePage extends StatefulWidget {
//   const AdminSchedulePage({super.key});
//
//   @override
//   State<AdminSchedulePage> createState() => _AdminSchedulePageState();
// }
//
// class _AdminSchedulePageState extends State<AdminSchedulePage>
//     with ScheduleDialogs {
//   String _noteText = "Add note";
//   final TextEditingController _noteController = TextEditingController();
//
//   String _statusText = "Open";
//
//   bool _isExpanded = false; // Состояние для управления видимостью кнопок
//
//   @override
//   void initState() {
//     super.initState();
//     _noteController.text = _noteText;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Header с "Shop Status" и иконкой меню
//             Padding(
//               padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
//               child: Row(
//                 children: [
//                   // Иконка меню с тремя линиями
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 24,
//                         height: 2,
//                         color: Color(0xFF84C164),
//                       ),
//                       SizedBox(height: 4),
//                       Container(
//                         width: 18,
//                         height: 2,
//                         color: Color(0xFF84C164),
//                       ),
//                       SizedBox(height: 4),
//                       Container(
//                         width: 12,
//                         height: 2,
//                         color: Color(0xFF84C164),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     'Shop Status',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF84C164),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 30),
//
//             // Кнопка "Open"
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _isExpanded = !_isExpanded; // Переключаем состояние
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 60),
//                 padding: EdgeInsets.symmetric(vertical: 13),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(0),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Image.asset(
//                         'assets/icons/linesforschedule.png',
//                         width: 20,
//                         height: 20,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       _statusText,
//                       style: TextStyle(
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Раскрывающиеся кнопки "Break" и "Closed"
//             if (_isExpanded) // Показываем, если _isExpanded == true
//               Column(
//                 children: [
//                   SizedBox(height: 16),
//                   StatusButton(
//                     text: "Break",
//                     color: Colors.orange,
//                     onPressed: () {
//                       setState(() {
//                         _statusText = "Break";
//                         _isExpanded = false; // Скрываем кнопки после выбора
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   StatusButton(
//                     text: "Closed",
//                     color: Colors.red,
//                     onPressed: () {
//                       setState(() {
//                         _statusText = "Closed";
//                         _isExpanded = false; // Скрываем кнопки после выбора
//                       });
//                     },
//                   ),
//                 ],
//               ),
//
//             SizedBox(height: 25),
//
//             // Заметка
//             GestureDetector(
//               onTap: () {
//                 ScheduleDialogs.showEditNoteDialog(
//                   context: context,
//                   controller: _noteController,
//                   onSave: (newNote) { // Use "onSave" instead of "onSaved"
//                     setState(() {
//                       _noteText = newNote;
//                     });
//                   },
//                 );
//
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(0),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(7.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Иконка
//                         Image.asset(
//                           'assets/icons/chatplus.png',
//                           width: 20,
//                           height: 20,
//                         ),
//                         SizedBox(width: 8),
//                         // Текст
//                         Text(
//                           _noteText,
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//
//             // Основной контейнер с календарем и расписанием
//             ScheduleCalendar(
//               weekSchedule: {},
//               onSave: () {
//                 setState(() {
//
//                 });
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
