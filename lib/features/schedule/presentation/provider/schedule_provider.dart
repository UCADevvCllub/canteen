import 'dart:async';

import 'package:canteen/core/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:canteen/features/schedule/data/schedule_service.dart';
import 'package:canteen/features/schedule/domain/models/schedule_model.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleService scheduleService;
  final UserService userService;

  ScheduleProvider(this.scheduleService, this.userService) {
    _initialize();
  }

  String _currentStatus = 'Unknown';
  String _note = '';
  bool _isLoading = false;
  List<ScheduleModel> _weeklySchedule = [];

  late final StreamSubscription _statusSubscription;
  late final StreamSubscription _noteSubscription;

  bool get isLoading => _isLoading;
  bool get isUserAdmin => userService.isAdmin();
  List<ScheduleModel> get weeklySchedule => _weeklySchedule;
  String get currentStatus => _currentStatus;
  String get note => _note;

  Future<void> _initialize() async {
    _setLoading(true);

    try {
      await fetchWeeklySchedule();
      _listenToStatus();
      _listenToNote();
    } catch (e) {
      debugPrint('Initialization error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchWeeklySchedule() async {
    try {
      _weeklySchedule = await scheduleService.getAllSchedules();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching schedules: $e');
    }
  }

  Future<void> updateSchedule(ScheduleModel schedule) async {
    try {
      await scheduleService.updateSchedule(schedule);
      await fetchWeeklySchedule();
    } catch (e) {
      debugPrint('Error updating schedule: $e');
    }
  }

  ScheduleModel? getScheduleForDay(String dayOfTheWeek) {
    try {
      return _weeklySchedule.firstWhere(
        (s) => s.dayOfTheWeek == dayOfTheWeek,
      );
    } catch (e) {
      debugPrint('Error getting schedule for day: $e');
      return null;
    }
  }

  /// 🔁 Listens to Firestore status document for real-time updates
  void _listenToStatus() {
    _statusSubscription = scheduleService.statusStream().listen((newStatus) {
      _currentStatus = newStatus;
      notifyListeners();
    });
  }

  /// Updates the note in the schedule
  void _listenToNote() {
    _noteSubscription = scheduleService.noteStream().listen((newNote) {
      _note = newNote;
      notifyListeners();
    });
  }

  /// Used by admin to manually change the status
  Future<void> changeStatus(String newStatus) async {
    try {
      await scheduleService.changeStatus(newStatus);
    } catch (e) {
      debugPrint('Error changing status: $e');
    }
  }

  Future<void> updateNote(String newNote) async {
    try {
      await scheduleService.updateNote(newNote);
    } catch (e) {
      debugPrint('Error updating note: $e');
    }
  }

  /// Legacy method — no longer needed but can still be used for fallback
  Future<void> getCurrentStatus() async {
    try {
      final status = await scheduleService.getStatus();
      _currentStatus = status;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching current status: $e');
    }
  }

  Future<void> getNote() async {
    try {
      final note = await scheduleService.getNote();
      _note = note;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching note: $e');
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _statusSubscription.cancel();
    _noteSubscription.cancel();
    super.dispose();
  }
}
