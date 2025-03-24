import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteen/features/schedule/presentation/helpers/schedule_dialogs.dart';
import 'package:canteen/features/schedule/presentation/widgets/schedule_calendar.dart';
import 'package:canteen/features/schedule/presentation/widgets/status_button.dart';
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
  bool _isExpanded = false;
  Map<String, dynamic> _weekSchedule = {};

  @override
  void initState() {
    super.initState();
    _noteController.text = _noteText;
    _loadData();
  }

  Future<void> _loadData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('admin_schedule')
        .doc('shop_status')
        .get();

    if (doc.exists) {
      setState(() {
        _statusText = doc['status'] ?? "Open";
        _noteText = doc['note'] ?? "Add note";
        _weekSchedule = Map<String, dynamic>.from(doc['weekSchedule'] ?? {});
        _noteController.text = _noteText;
      });
    }
  }

  Future<void> _saveData() async {
    await FirebaseFirestore.instance.collection('admin_schedule').doc('shop_status').set({
      'status': _statusText,
      'note': _noteText,
      'weekSchedule': _weekSchedule,
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
                      Container(width: 24, height: 2, color: Color(0xFF84C164)),
                      SizedBox(height: 4),
                      Container(width: 18, height: 2, color: Color(0xFF84C164)),
                      SizedBox(height: 4),
                      Container(width: 12, height: 2, color: Color(0xFF84C164)),
                    ],
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Shop Status',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF84C164)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 60),
                padding: EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Image.asset('assets/icons/linesforschedule.png', width: 20, height: 20),
                    ),
                    SizedBox(width: 8),
                    Text(
                      _statusText,
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            if (_isExpanded)
              Column(
                children: [
                  SizedBox(height: 16),
                  StatusButton(text: "Break", color: Colors.orange, onPressed: () => setState(() => _statusText = "Break")),
                  SizedBox(height: 16),
                  StatusButton(text: "Closed", color: Colors.red, onPressed: () => setState(() => _statusText = "Closed")),
                ],
              ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                showEditNoteDialog(
                  context: context,
                  controller: _noteController,
                  onSaved: () => setState(() => _noteText = _noteController.text),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/chatplus.png', width: 20, height: 20),
                        SizedBox(width: 8),
                        Text(
                          _noteText,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            ScheduleCalendar(
              onSaved: () => _saveData(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}