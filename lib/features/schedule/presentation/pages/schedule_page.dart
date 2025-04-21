import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:canteen/features/schedule/presentation/widgets/layout/shop_status_header.dart';
import 'package:canteen/features/schedule/presentation/widgets/fields/status_selector.dart';
import 'package:canteen/features/schedule/presentation/widgets/fields/note_section.dart';
import 'package:canteen/features/schedule/presentation/widgets/calendar_section.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ScheduleProvider>(builder: (context, provider, _) {
        final isAdmin = provider.isUserAdmin;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ShopStatusHeader(),
              const SizedBox(height: 30),
              StatusSelector(),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NoteSection(),
                ],
              ),
              CalendarSection(
                isAdmin: isAdmin,
                calendarFormat: _calendarFormat,
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selectedDay, focusedDay) => setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                }),
                onFormatChanged: (format) =>
                    setState(() => _calendarFormat = format),
              ),
            ],
          ),
        );
      }),
    );
  }
}
