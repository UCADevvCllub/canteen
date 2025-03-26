import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:canteen/features/schedule/presentation/widgets/schedule_calendar.dart';
import 'package:canteen/features/schedule/presentation/widgets/admin_shop_status_widget.dart';
import 'package:canteen/features/schedule/presentation/widgets/admin_note_widget.dart';
import 'package:canteen/features/schedule/presentation/widgets/status_widget.dart';

class AdminSchedulePage extends StatefulWidget {
  const AdminSchedulePage({super.key});

  @override
  State<AdminSchedulePage> createState() => _AdminSchedulePageState();
}

class _AdminSchedulePageState extends State<AdminSchedulePage> {
  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref('admin_schedule/shop_status');

  String _noteText = "Add note";
  final TextEditingController _noteController = TextEditingController();
  String _statusText = "Open";
  Map<String, Map<String, String>> _weekSchedule = {};

  @override
  void initState() {
    super.initState();
    _noteController.text = _noteText;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final snapshot = await _dbRef.get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          _statusText = data['status']?.toString() ?? "Open";
          _noteText = data['note']?.toString() ?? "Add note";
          _weekSchedule = (data['week_schedule'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(
              key,
              Map<String, String>.from(value),
            ),
          );
          _noteController.text = _noteText;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки: $e')),
      );
    }
  }

  Future<void> _saveData() async {
    try {
      await _dbRef.update({
        'status': _statusText,
        'note': _noteText,
        'week_schedule': _weekSchedule,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка сохранения: $e')),
      );
    }
  }

  void _updateStatus(String newStatus) {
    setState(() => _statusText = newStatus);
    _dbRef.child('status').set(newStatus).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка сохранения статуса: $error')),
      );
    });
  }

  void _updateNote() {
    final newNote = _noteController.text;
    setState(() => _noteText = newNote);
    _dbRef.child('note').set(newNote).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка сохранения заметки: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AdminShopStatusWidget(),
            const SizedBox(height: 30),
            StatusWidget(
              statusText: _statusText,
              onStatusChange: _updateStatus,
            ),
            const SizedBox(height: 25),
            AdminNoteWidget(
              noteText: _noteText,
              controller: _noteController,
              onSaved: _updateNote,
            ),
            const SizedBox(height: 15),
            ScheduleCalendar(weekSchedule: _weekSchedule),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}