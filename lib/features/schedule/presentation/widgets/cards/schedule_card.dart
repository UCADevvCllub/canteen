import 'package:canteen/core/config/app_date_config.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/features/schedule/domain/models/schedule_model.dart';
import 'package:canteen/features/schedule/presentation/helpers/dialogs/schedule_dialog.dart';
import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';
import 'package:canteen/features/schedule/presentation/widgets/layout/schedule_time_slots.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleCard extends StatefulWidget {
  final ScheduleModel schedule;

  const ScheduleCard({
    super.key,
    required this.schedule,
  });

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> with ScheduleDialog {
  bool isToday = false;
  ScheduleModel schedule = ScheduleModel.empty();

  @override
  void initState() {
    super.initState();
    schedule = widget.schedule;
    _checkIfToday();
  }

  void _checkIfToday() {
    final today = DateTime.now();
    final scheduleDate =
        AppDateConfig.getDateForDayOfWeek(widget.schedule.dayOfTheWeek);
    isToday = today.year == scheduleDate.year &&
        today.month == scheduleDate.month &&
        today.day == scheduleDate.day;
  }

  @override
  Widget build(BuildContext context) {
    final isWeekend = AppDateConfig.isWeekend(widget.schedule.dayOfTheWeek);
    final scheduleDate =
        AppDateConfig.getDateForDayOfWeek(widget.schedule.dayOfTheWeek);
    final formattedDate = DateFormat('MMMM d, yyyy').format(scheduleDate);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: isToday ? AppColors.primarySwatch.shade100 : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildDayHeader(context, isWeekend),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formattedDate, style: _dateTextStyle(isToday)),
              ScheduleTimeSlots(schedule: schedule),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayHeader(BuildContext context, bool isWeekend) {
    bool isAdmin =
        Provider.of<ScheduleProvider>(context, listen: false).isUserAdmin;
    if (!isWeekend) {
      return GestureDetector(
        onTap: () async {
          if (isAdmin) {
            final result = await showScheduleDialog(
              context: context,
              schedule: widget.schedule,
            );

            if (result != null) {
              setState(() {
                schedule = result;
              });
              Provider.of<ScheduleProvider>(context, listen: false)
                  .updateSchedule(result);
            }
          }
        },
        child: Row(
          children: [
            isAdmin
                ? Image.asset(
                    'assets/icons/scheduleday.png',
                    width: 24,
                    height: 24,
                  )
                : const SizedBox(),
            Expanded(
              child: Center(
                child: Text(
                  widget.schedule.dayOfTheWeek,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          widget.schedule.dayOfTheWeek,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
    }
  }

  TextStyle _dateTextStyle(bool isToday) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
}
