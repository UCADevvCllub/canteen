import 'package:flutter/material.dart';

class AdminShopStatusWidget extends StatelessWidget {
  const AdminShopStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 24, height: 2, color: Color(0xFF84C164)),
              SizedBox(height: 4),
              Container(width: 18, height: 2, color: Color(0xFF84C164)),
              SizedBox(height: 4),
              Container(width: 12, height: 2, color: Color(0xFF84C164)),
            ],
          ),
          SizedBox(width: 10),
          Text(
            'Shop Status',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF84C164)),
          ),
        ],
      ),
    );
  }
}
