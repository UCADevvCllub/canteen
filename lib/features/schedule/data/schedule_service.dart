import 'package:canteen/features/schedule/domain/models/schedule_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String scheduleCollection = 'schedule';
  final String statusDocPath = 'app_settings/status';
  final String noteDocPath = 'app_settings/note';

  // Fetch all weekly schedules
  Future<List<ScheduleModel>> getAllSchedules() async {
    final snapshot = await _firestore.collection(scheduleCollection).get();
    return snapshot.docs.map((doc) {
      return ScheduleModel.fromMap(doc.data());
    }).toList();
  }

  // Update a specific schedule
  Future<void> updateSchedule(ScheduleModel schedule) async {
    await _firestore
        .collection(scheduleCollection)
        .doc(schedule.dayOfTheWeek)
        .set(schedule.toMap());
  }

  // Get schedule for a specific day
  Future<ScheduleModel?> getScheduleForDay(String dayOfTheWeek) async {
    final doc =
        await _firestore.collection(scheduleCollection).doc(dayOfTheWeek).get();
    if (doc.exists) {
      return ScheduleModel.fromMap(doc.data()!);
    }
    return null;
  }

  // Status
  Future<String> getStatus() async {
    final doc = await _firestore.doc(statusDocPath).get();
    if (doc.exists) {
      return doc.data()?['value'] ?? 'Unknown';
    } else {
      return 'Unknown';
    }
  }

  Future<void> changeStatus(String newStatus) async {
    await _firestore.doc(statusDocPath).set({
      'value': newStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<String> statusStream() {
    return _firestore.doc(statusDocPath).snapshots().map((doc) {
      return doc.data()?['value'] ?? 'Unknown';
    });
  }

  // Note
  Future<String> getNote() async {
    final doc = await _firestore.doc(noteDocPath).get();
    if (doc.exists) {
      return doc.data()?['note'];
    } else {
      return 'No note available';
    }
  }

  Future<void> updateNote(String newNote) async {
    await _firestore.doc(noteDocPath).update({
      'note': newNote,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<String> noteStream() {
    return _firestore.doc(noteDocPath).snapshots().map((doc) {
      return doc.data()?['note'] ?? 'No note available';
    });
  }
}
