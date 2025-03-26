import 'package:flutter/material.dart';

class WeekScheduleWidget extends StatelessWidget {
  final Map<String, Map<String, String>> weekSchedule;

  const WeekScheduleWidget({super.key, required this.weekSchedule});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: weekSchedule.length,
      itemBuilder: (context, index) {
        String day = weekSchedule.keys.elementAt(index);
        Map<String, String> schedule = weekSchedule[day] ?? {};

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${schedule['open']} - ${schedule['break']} - ${schedule['closed']}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
