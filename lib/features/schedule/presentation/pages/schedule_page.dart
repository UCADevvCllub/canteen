import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/schedule/presentation/widgets/shop_status_header.dart';
import 'package:canteen/features/schedule/presentation/widgets/status_selector.dart';
import 'package:canteen/features/schedule/presentation/widgets/note_section.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<bool>(
        future: _adminCheckFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading schedule data'));
          }

          final isAdmin = snapshot.data ?? false;

          return SingleChildScrollView(
            child: Column(
              children: [
                const ShopStatusHeader(),
                const SizedBox(height: 30),
                StatusSelector(
                  isAdmin: isAdmin,
                  currentStatus: _currentStatus,
                  onStatusChanged: (newStatus) => setState(() => _currentStatus = newStatus),
                ),
                const SizedBox(height: 25),
                NoteSection(
                  isAdmin: isAdmin,
                  currentNote: _currentNote,
                  noteController: _noteController,
                  onEditNote: _editNote,
                ),
                CalendarSection(
                  isAdmin: isAdmin,
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  scheduleTimes: _scheduleTimes,
                  onDaySelected: (selectedDay, focusedDay) => setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  }),
                  onFormatChanged: (format) => setState(() => _calendarFormat = format),
                  onEditTime: _editTimeDialog,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}