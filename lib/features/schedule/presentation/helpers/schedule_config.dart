import 'package:canteen/features/schedule/domain/models/schedule_model.dart';
import 'package:canteen/features/schedule/domain/models/time_range.dart';
import 'package:intl/intl.dart';

class ScheduleConfig {
  static List<ScheduleModel> getWeeklySchedule(DateTime startDate) {
    final DateFormat dayFormat = DateFormat('EEEE');
    List<ScheduleModel> schedule = [];

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String day = dayFormat.format(currentDate);
      if (i == 0) {
        day = "Today";
      }

      schedule.add(
        ScheduleModel(
          dayOfTheWeek: day,
          open: TimeRange(startTime: "08:00", endTime: "12:00"),
          breakTime: TimeRange(startTime: "12:00", endTime: "13:00"),
          close: TimeRange(startTime: "13:00", endTime: "17:00"),
        ),
      );
    }

    return schedule;
  }
}
