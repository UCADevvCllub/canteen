import 'package:canteen/features/schedule/domain/models/schedule_model.dart';
import 'package:canteen/features/schedule/domain/models/time_range.dart';
import 'package:flutter/material.dart';

class ScheduleTimeSlots extends StatelessWidget {
  const ScheduleTimeSlots({super.key, required this.schedule});

  final ScheduleModel schedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildTimeRow('Open', schedule.open),
        _buildTimeRow('Break', schedule.breakTime),
        _buildTimeRow('Closed', schedule.close),
      ],
    );
  }

  Widget _buildTimeRow(String label, TimeRange time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${time.startTime} - ${time.endTime}",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
