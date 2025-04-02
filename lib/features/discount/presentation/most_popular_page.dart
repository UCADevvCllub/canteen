import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/widgets/cards/discount_card_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MostPopularPage extends StatelessWidget {
  const MostPopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background image added here
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/layouts/home_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent, // Transparent to show background
          appBar: AppBar(
            title: const Text(
              "Most Popular",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent, // Transparent AppBar
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const DiscountCardWidget(
                  imagePath: 'assets/product_images/jin_ramen.png',
                  title: 'Jin RAMEN MILD..',
                  newPrice: '160 som',
                  showStar: true,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}