import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:canteen/features/schedule/presentation/widgets/shop_status_widget.dart';
import 'package:canteen/features/schedule/presentation/widgets/note_widget.dart';
import 'package:canteen/features/schedule/presentation/widgets/week_schedule_widget.dart';
import 'package:canteen/features/schedule/presentation/widgets/schedule_calendar.dart';
import 'package:canteen/features/schedule/presentation/helpers/schedule_dialogs.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref('admin_schedule/shop_status');

  Stream<DatabaseEvent> _getScheduleStream() => _dbRef.onValue;

  Map<String, Map<String, String>> _parseData(dynamic data) {
    return (data['week_schedule'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
        key,
        Map<String, String>.from(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _getScheduleStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Ошибка: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const Scaffold(
            body: Center(child: Text('Данные не найдены')),
          );
        }

        final data = Map<String, dynamic>.from(
          snapshot.data!.snapshot.value as Map,
        );

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
                children: [
                const SizedBox(height: 50),
                  const Text(
                    'Shop Status',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF84C164),
                    ), // <- Закрывающая скобка для TextStyle
                  ), // <- Закрывающая скобка для Text
                  const SizedBox(height: 30),
                  ShopStatusWidget(status: data['status']?.toString() ?? 'Open'),
              const SizedBox(height: 25),
              NoteWidget(note: data['note']?.toString() ?? 'Add note'),
              const SizedBox(height: 20),
              WeekScheduleWidget(weekSchedule: _parseData(data)),
              const SizedBox(height: 20),
              ScheduleCalendar(weekSchedule: _parseData(data)),
              ],
            ),
          ),
        );
      },
    );
  }
}