import 'package:flutter/material.dart';

class ShopStatusWidget extends StatelessWidget {
  final String status;

  const ShopStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == "Open"
        ? Colors.green
        : status == "Break"
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 13),
      decoration: BoxDecoration(color: statusColor),
      child: Text(
        status,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
