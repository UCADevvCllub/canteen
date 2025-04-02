import 'package:flutter/material.dart';
import 'package:canteen/features/schedule/presentation/widgets/expandable_status_selector.dart';
import 'package:canteen/features/schedule/presentation/widgets/non_admin_status_display.dart';

class StatusSelector extends StatelessWidget {
  final bool isAdmin;
  final String currentStatus;
  final ValueChanged<String> onStatusChanged;

  const StatusSelector({
    super.key,
    required this.isAdmin,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return isAdmin
        ? ExpandableStatusSelector(
      currentStatus: currentStatus,
      onStatusChanged: onStatusChanged,
    )
        : NonAdminStatusDisplay(currentStatus: currentStatus);
  }
}