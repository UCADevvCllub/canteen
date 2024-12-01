import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery"),
      ),
      body: Center(
        child: Text(
          "This is the Delivery Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
