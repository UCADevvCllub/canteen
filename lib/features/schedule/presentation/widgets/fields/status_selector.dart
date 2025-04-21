import 'package:canteen/features/schedule/presentation/helpers/dialogs/status_dialog.dart';
import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusSelector extends StatefulWidget {
  const StatusSelector({super.key});

  @override
  State<StatusSelector> createState() => _StatusSelectorState();
}

class _StatusSelectorState extends State<StatusSelector> with StatusDialog {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, child) {
        final isAdmin = scheduleProvider.isUserAdmin;
        final currentStatus = scheduleProvider.currentStatus;
        final isLoading = scheduleProvider.isLoading;

        return GestureDetector(
          onTap: () async {
            if (isAdmin && !isLoading) {
              final newStatus = await showStatusDialog(
                context: context,
                currentStatus: currentStatus,
              );

              if (newStatus != null && newStatus != currentStatus) {
                await scheduleProvider.changeStatus(newStatus);
              }
            }
          },
          child: Container(
            color: _getStatusColor(currentStatus),
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: kToolbarHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLoading)
                  const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else ...[
                  if (isAdmin)
                    Image.asset(
                      'assets/icons/linesforschedule.png',
                      width: 20,
                      height: 20,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    currentStatus,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.green;
      case 'Break':
        return Colors.orange;
      case 'Closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
