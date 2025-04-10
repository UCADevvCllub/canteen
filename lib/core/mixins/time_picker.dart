import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin TimePicker {
  Future<void> showPlatformTimePicker({
    required BuildContext context,
    required TextEditingController controller,
    TimeOfDay? initialTime,
  }) async {
    final now = TimeOfDay.now();
    final selectedTime = initialTime ?? now;

    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (_) {
          TimeOfDay pickedTime = selectedTime;
          return Container(
            height: 300,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: const Text('Done'),
                      onPressed: () {
                        controller.text = _formatTime(pickedTime);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                    onDateTimeChanged: (DateTime dateTime) {
                      pickedTime = TimeOfDay.fromDateTime(dateTime);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (picked != null) {
        controller.text = _formatTime(picked);
      }
    }
  }

  String _formatTime(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
