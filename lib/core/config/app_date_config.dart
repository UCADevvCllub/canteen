class AppDateConfig {
  static bool isWeekend(String day) => day == "Saturday" || day == "Sunday";

  static DateTime getDateForDayOfWeek(String dayOfTheWeek) {
    final daysOfWeek = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };

    final now = DateTime.now();
    final mondayThisWeek = now.subtract(Duration(days: now.weekday - 1));
    final targetWeekday = daysOfWeek[dayOfTheWeek];

    if (targetWeekday == null) {
      throw ArgumentError('Invalid day of the week: $dayOfTheWeek');
    }

    return mondayThisWeek.add(Duration(days: targetWeekday - 1));
  }
}
