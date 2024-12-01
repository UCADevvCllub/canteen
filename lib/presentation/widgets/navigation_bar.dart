import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      // Текущий выбранный индекс
      items: <Widget>[
        Icon(
          Icons.percent, // Иконка для "долг/скидка"
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.local_shipping, // Иконка для "доставка"
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.shopping_cart, // Иконка для "продукты"
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.thumb_up, // Иконка для "рекомендации" (или поменять на другую)
          size: 30,
          color: Colors.black,
        ),
        Icon(
          Icons.schedule, // Иконка для "расписание"
          size: 30,
          color: Colors.black,
        ),
      ],
      onTap: onTap,
      backgroundColor: Color(0xFFD9D9D9),
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      height: 50,
      animationCurve: Curves.bounceInOut,
      animationDuration: const Duration(milliseconds: 150),
    );
  }
}
