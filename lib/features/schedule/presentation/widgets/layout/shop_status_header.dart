import 'package:flutter/material.dart';
import 'package:canteen/features/profile/presentation/pages/profile_page.dart'; // Import ProfilePage

class ShopStatusHeader extends StatelessWidget {
  const ShopStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            child: Image.asset(
              'assets/icons/menu.png',
              width: 24,
              height: 24,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 15),
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