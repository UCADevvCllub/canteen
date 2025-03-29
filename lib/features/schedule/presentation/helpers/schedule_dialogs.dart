import 'package:canteen/features/schedule/presentation/helpers/schedule_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin ScheduleDialogs {
  // void showEditTimeDialog(BuildContext context,
  //     {required VoidCallback onSaved}) {
  //   final schedule = ScheduleConfig.getWeeklySchedule(DateTime.now());

  //   TextEditingController openController =
  //       TextEditingController(text: schedule['open']);
  //   TextEditingController breakController =
  //       TextEditingController(text: schedule['break']);
  //   TextEditingController closedController =
  //       TextEditingController(text: schedule['closed']);
  //   TextEditingController dateController =
  //       TextEditingController(text: schedule['date']);

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Edit Time for ${schedule['day']}'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: dateController,
  //               decoration: InputDecoration(
  //                 labelText: 'Date',
  //                 suffixIcon: IconButton(
  //                   icon: Icon(Icons.calendar_today),
  //                   onPressed: () async {
  //                     DateTime? pickedDate = await showDatePicker(
  //                       context: context,
  //                       initialDate: DateTime.now(),
  //                       firstDate: DateTime(2000),
  //                       lastDate: DateTime(2100),
  //                     );
  //                     if (pickedDate != null) {
  //                       dateController.text =
  //                           DateFormat('MMMM d, y').format(pickedDate);
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ),
  //             TextField(
  //               controller: openController,
  //               decoration: InputDecoration(
  //                 labelText: 'Open Time',
  //                 suffixIcon: IconButton(
  //                   icon: Icon(Icons.access_time),
  //                   onPressed: () async {
  //                     TimeOfDay? pickedTime = await showTimePicker(
  //                       context: context,
  //                       initialTime: TimeOfDay.now(),
  //                     );
  //                     if (pickedTime != null) {
  //                       openController.text = pickedTime.format(context);
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ),
  //             TextField(
  //               controller: breakController,
  //               decoration: InputDecoration(
  //                 labelText: 'Break Time',
  //                 suffixIcon: IconButton(
  //                   icon: Icon(Icons.access_time),
  //                   onPressed: () async {
  //                     TimeOfDay? pickedTime = await showTimePicker(
  //                       context: context,
  //                       initialTime: TimeOfDay.now(),
  //                     );
  //                     if (pickedTime != null) {
  //                       breakController.text = pickedTime.format(context);
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ),
  //             TextField(
  //               controller: closedController,
  //               decoration: InputDecoration(
  //                 labelText: 'Closed Time',
  //                 suffixIcon: IconButton(
  //                   icon: Icon(Icons.access_time),
  //                   onPressed: () async {
  //                     TimeOfDay? pickedTime = await showTimePicker(
  //                       context: context,
  //                       initialTime: TimeOfDay.now(),
  //                     );
  //                     if (pickedTime != null) {
  //                       closedController.text = pickedTime.format(context);
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               onSaved();
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Save'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void showEditNoteDialog({
    required BuildContext context,
    required TextEditingController controller,
    required VoidCallback onSaved,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter your note here',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                onSaved();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
