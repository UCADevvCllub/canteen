import 'package:canteen/core/mixins/time_picker.dart';
import 'package:flutter/material.dart';

class TimeRangeSelector extends StatefulWidget {
  const TimeRangeSelector({
    super.key,
    required this.type,
    required this.startTime,
    required this.endTime,
  });

  final String type;
  final TextEditingController startTime;
  final TextEditingController endTime;

  @override
  State<TimeRangeSelector> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> with TimePicker {
  Color get iconColor {
    switch (widget.type) {
      case 'Open':
        return Colors.green;
      case 'Break':
        return Colors.yellow;
      case 'Closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.type.toUpperCase(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.access_time,
              color: iconColor,
              size: 28,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildTimeField(
                context: context,
                label: 'From',
                controller: widget.startTime,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTimeField(
                context: context,
                label: 'To',
                controller: widget.endTime,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
  }) {
    return GestureDetector(
      onTap: () async {
        await showPlatformTimePicker(
          context: context,
          controller: controller,
        );
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          controller.text.isEmpty ? label : controller.text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
