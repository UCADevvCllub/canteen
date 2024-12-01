import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Product Page",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to the Product Page!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Image.asset(
            'assets/images/debt_icon.png',
            width: 30,
            height: 30,
          ),
          Image.asset(
            'assets/images/delivery_icon.png',
            width: 30,
            height: 30,
          ),
          Image.asset(
            'assets/images/products_icon.png',
            width: 30,
            height: 30,
          ),
          Image.asset(
            'assets/images/recommendation_icon.png',
            width: 30,
            height: 30,
          ),
          Image.asset(
            'assets/images/schedule_icon.png',
            width: 30,
            height: 30,
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              debugPrint("Debt Icon Pressed");
              break;
            case 1:
              debugPrint("Delivery Icon Pressed");
              break;
            case 2:
              debugPrint("Products Icon Pressed");
              break;
            case 3:
              debugPrint("Recommendation Icon Pressed");
              break;
            case 4:
              debugPrint("Schedule Icon Pressed");
              break;
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProductPage(),
  ));
}
