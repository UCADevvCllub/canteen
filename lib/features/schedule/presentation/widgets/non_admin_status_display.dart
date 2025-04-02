import 'package:flutter/material.dart';

class NonAdminStatusDisplay extends StatelessWidget {
  final String currentStatus;

  const NonAdminStatusDisplay({
    super.key,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Text(
        currentStatus,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}