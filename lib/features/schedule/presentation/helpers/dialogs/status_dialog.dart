import 'package:flutter/material.dart';
import 'package:canteen/features/schedule/presentation/widgets/buttons/status_button.dart';

mixin StatusDialog<T extends StatefulWidget> on State<T> {
  Future<String?> showStatusDialog({
    required BuildContext context,
    required String currentStatus,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatusButton(
                  text: "Open",
                  color: Colors.green,
                  onPressed: () => Navigator.pop(ctx, "Open"),
                ),
                const SizedBox(height: 16),
                StatusButton(
                  text: "Break",
                  color: Colors.orange,
                  onPressed: () => Navigator.pop(ctx, "Break"),
                ),
                const SizedBox(height: 16),
                StatusButton(
                  text: "Closed",
                  color: Colors.red,
                  onPressed: () => Navigator.pop(ctx, "Closed"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
