import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/widgets/cards/discount_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canteen/features/products/presentation/provider/product_provider.dart'; // Add ProductProvider import

@RoutePage()
class MostPopularPage extends StatelessWidget {
  const MostPopularPage({super.key});

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
              "Most Popular",
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    print("Save icon tapped");
                  },
                  child: Image.asset(
                    'assets/icons/menu.png', // Replace with working icon from DiscountsPage
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
          body: Consumer<ProductProvider>(
            builder: (context, provider, _) {
              final products = provider.products;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: products.isEmpty
                    ? const Center(
                  child: Text(
                    "No popular products available",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return DiscountCardWidget(
                      imageUrl: product.imageUrl, // Use dynamic image URL
                      title: product.name,
                      newPrice: '160 som', // Placeholder; update with real price if available
                      showStar: true, imagePath: 'assets/product_images/jin_ramen.jpg',
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}