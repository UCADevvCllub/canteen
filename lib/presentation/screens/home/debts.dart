import 'package:flutter/material.dart';

class DebtsPage extends StatelessWidget {
  const DebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debts"),
      ),
      body: Center(
        child: Text(
          "This is the Debts Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
