class TimeRange {
  final String startTime;
  final String endTime;

  TimeRange({required this.startTime, required this.endTime});

  factory TimeRange.fromMap(Map<String, dynamic> map) {
    return TimeRange(
      startTime: map['startTime'],
      endTime: map['endTime'],
    );
  }

  Map<String, String> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  TimeRange copyWith({
    String? startTime,
    String? endTime,
  }) {
    return TimeRange(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
