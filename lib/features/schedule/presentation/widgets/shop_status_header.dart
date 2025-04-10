// widgets/shop_status_header.dart
import 'package:flutter/material.dart';

class ShopStatusHeader extends StatelessWidget {
  const ShopStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 24, height: 2, color: const Color(0xFF84C164)),
              const SizedBox(height: 4),
              Container(width: 18, height: 2, color: const Color(0xFF84C164)),
              const SizedBox(height: 4),
              Container(width: 12, height: 2, color: const Color(0xFF84C164)),
            ],
          ),
          const SizedBox(width: 10),
          const Text(
            'Shop Status',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF84C164),
            ),
          ),
        ],
      ),
    );
  }
}
