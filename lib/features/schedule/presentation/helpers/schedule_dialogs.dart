import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin ScheduleDialogs {
  static Future<Map<String, String>?> showEditTimeDialog(
      BuildContext context, {
        required String initialDay,
        required String initialOpen,
        required String initialBreak,
        required String initialClosed,
      }) async {
    final TextEditingController openController =
    TextEditingController(text: initialOpen);
    final TextEditingController breakController =
    TextEditingController(text: initialBreak);
    final TextEditingController closedController =
    TextEditingController(text: initialClosed);

    return await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Time for $initialDay'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimeField(
                  context,
                  controller: openController,
                  label: 'Open Time',
                ),
                _buildTimeField(
                  context,
                  controller: breakController,
                  label: 'Break Time',
                ),
                _buildTimeField(
                  context,
                  controller: closedController,
                  label: 'Closed Time',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final result = {
                  'open': openController.text,
                  'break': breakController.text,
                  'closed': closedController.text,
                };
                Navigator.pop(context, result);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildTimeField(
      BuildContext context, {
        required TextEditingController controller,
        required String label,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            icon: const Icon(Icons.access_time),
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: _parseTime(controller.text),
              );
              if (time != null) {
                controller.text = _formatTime(time);
              }
            },
          ),
        ),
      ),
    );
  }

  static TimeOfDay _parseTime(String time) {
    try {
      final format = DateFormat.jm();
      final date = format.parse(time);
      return TimeOfDay.fromDateTime(date);
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  static String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  static Future<void> showEditNoteDialog({
    required BuildContext context,
    required TextEditingController controller,
    required Function(String) onSave,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Enter your note here',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}