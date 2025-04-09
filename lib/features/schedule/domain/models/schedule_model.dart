import 'package:canteen/features/schedule/domain/models/time_range.dart';

class ScheduleModel {
  final String dayOfTheWeek;
  final TimeRange open;
  final TimeRange breakTime;
  final TimeRange close;

  ScheduleModel({
    required this.dayOfTheWeek,
    required this.open,
    required this.breakTime,
    required this.close,
  });

  ScheduleModel.empty()
      : dayOfTheWeek = '',
        open = TimeRange(startTime: '', endTime: ''),
        breakTime = TimeRange(startTime: '', endTime: ''),
        close = TimeRange(startTime: '', endTime: '');

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      dayOfTheWeek: map['dayOfTheWeek'],
      open: TimeRange.fromMap(map['open']),
      breakTime: TimeRange.fromMap(map['break']),
      close: TimeRange.fromMap(map['close']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayOfTheWeek': dayOfTheWeek,
      'open': open.toMap(),
      'break': breakTime.toMap(),
      'close': close.toMap(),
    };
  }

  ScheduleModel copyWith({
    String? dayOfTheWeek,
    TimeRange? open,
    TimeRange? breakTime,
    TimeRange? close,
  }) {
    return ScheduleModel(
      dayOfTheWeek: dayOfTheWeek ?? this.dayOfTheWeek,
      open: open ?? this.open,
      breakTime: breakTime ?? this.breakTime,
      close: close ?? this.close,
    );
  }
}
