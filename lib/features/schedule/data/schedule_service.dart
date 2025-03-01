import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addWeeklySchedule() async {
    try {

      await _firestore.collection('admin_schedule').doc('monday').set({
        'day': 'Monday',
        'open': '12:00-21:00',
        'break': '13:00-14:00',
        'closed': '21:00-12:00',
      });


      await _firestore.collection('admin_schedule').doc('tuesday').set({
        'day': 'Tuesday',
        'open': '12:00-21:00',
        'break': '13:00-14:00',
        'closed': '21:00-12:00',
      });

      // Добавляем документ для среды
      await _firestore.collection('admin_schedule').doc('wednesday').set({
        'day': 'Wednesday',
        'open': '12:00-21:00',
        'break': '13:00-14:00',
        'closed': '21:00-12:00',
      });


      await _firestore.collection('admin_schedule').doc('thursday').set({
        'day': 'Thursday',
        'open': '12:00-21:00',
        'break': '13:00-14:00',
        'closed': '21:00-12:00',
      });


      await _firestore.collection('admin_schedule').doc('friday').set({
        'day': 'Friday',
        'open': '12:00-21:00',
        'break': '13:00-14:00',
        'closed': '21:00-12:00',
      });


      await _firestore.collection('admin_schedule').doc('saturday').set({
        'day': 'Saturday',
        'open': '12:00-21:00',
        'break': '13:00-14:00',
        'closed': '21:00-12:00',
      });


      await _firestore.collection('admin_schedule').doc('sunday').set({
        'day': 'Sunday',
        'open': '12:00-21:00',
        'break': '13:00-14:00',
        'closed': '21:00-12:00',
      });

      print('Weekly schedule added successfully!');
    } catch (e) {
      print('Error adding weekly schedule: $e');
    }
  }


  Future<void> addWeeklyScheduleWithData(Map<String, dynamic> scheduleData) async {
    try {

      await _firestore.collection('admin_schedule').add(scheduleData);
      print('Weekly schedule added successfully!');
    } catch (e) {
      print('Error adding weekly schedule: $e');
    }
  }
}