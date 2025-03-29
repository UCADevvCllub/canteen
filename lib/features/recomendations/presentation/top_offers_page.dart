import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/widgets/cards/discount_card_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TopOffersPage extends StatelessWidget {
  const TopOffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/layouts/home_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "Top Offers",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
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
                childAspectRatio: 1,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const Center(
                  child: DiscountCardWidget(
                    imagePath: 'assets/product_images/Drinks.jpg',
                    title: 'Jin RAMEN MILD..',
                    oldPrice: '160 som',
                    newPrice: '48 som',
                    discount: '-30%',
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
