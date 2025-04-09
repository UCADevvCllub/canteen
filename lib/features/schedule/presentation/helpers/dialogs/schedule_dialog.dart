import 'package:canteen/core/widgets/buttons/app_button.dart';
import 'package:canteen/features/schedule/domain/models/schedule_model.dart';
import 'package:canteen/features/schedule/domain/models/time_range.dart';
import 'package:canteen/features/schedule/presentation/widgets/fields/time_range_selector.dart';
import 'package:flutter/material.dart';

mixin ScheduleDialog<T extends StatefulWidget> on State<T> {
  Future<ScheduleModel?> showScheduleDialog({
    required BuildContext context,
    required ScheduleModel schedule,
  }) {
    final openFromController =
        TextEditingController(text: schedule.open.startTime);
    final openToController = TextEditingController(text: schedule.open.endTime);
    final breakFromController =
        TextEditingController(text: schedule.breakTime.startTime);
    final breakToController =
        TextEditingController(text: schedule.breakTime.endTime);
    final closedFromController =
        TextEditingController(text: schedule.close.startTime);
    final closedToController =
        TextEditingController(text: schedule.close.endTime);

    return showDialog<ScheduleModel>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Date Picker
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            schedule.dayOfTheWeek,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Open Section
                      TimeRangeSelector(
                        type: 'Open',
                        startTime: openFromController,
                        endTime: openToController,
                      ),

                      const SizedBox(height: 32),

                      // Break Section
                      TimeRangeSelector(
                        type: 'Break',
                        startTime: breakFromController,
                        endTime: breakToController,
                      ),

                      const SizedBox(height: 32),

                      // Closed Section
                      TimeRangeSelector(
                        type: 'Closed',
                        startTime: closedFromController,
                        endTime: closedToController,
                      ),

                      const SizedBox(height: 48),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppButton(
                              title: 'Cancel',
                              color: Colors.white,
                              text: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              borderColor: Colors.green,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppButton(
                              title: 'Save',
                              text: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(
                                  ScheduleModel(
                                    dayOfTheWeek: schedule.dayOfTheWeek,
                                    open: TimeRange(
                                        startTime: openFromController.text,
                                        endTime: openToController.text),
                                    breakTime: TimeRange(
                                        startTime: breakFromController.text,
                                        endTime: breakToController.text),
                                    close: TimeRange(
                                        startTime: closedFromController.text,
                                        endTime: closedToController.text),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
