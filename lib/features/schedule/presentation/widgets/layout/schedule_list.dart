import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canteen/features/schedule/presentation/widgets/cards/schedule_card.dart';
import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';

class ScheduleList extends StatefulWidget {
  final DateTime? selectedDay;

  const ScheduleList({
    super.key,
    required this.selectedDay,
  });

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  void initState() {
    super.initState();
    Provider.of<ScheduleProvider>(context, listen: false).fetchWeeklySchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, provider, _) {
        final weeklySchedule = provider.weeklySchedule;
        return Column(
          children: weeklySchedule.map((schedule) {
            return ScheduleCard(
              schedule: schedule,
            );
          }).toList(),
        );
      },
    );
  }
}
