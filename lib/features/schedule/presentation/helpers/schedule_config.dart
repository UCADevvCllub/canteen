import 'package:canteen/presentation/pages/schedule/domain/models/schedule_model.dart';
import 'package:intl/intl.dart';

class ScheduleConfig {
  static List<ScheduleModel> getWeeklySchedule(DateTime startDate) {
    final DateFormat dateFormat = DateFormat('MMMM d, y');
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
          day: day,
          date: dateFormat.format(currentDate),
          status: 'Open',
        ),
      );
    }

    return schedule;
  }
}
