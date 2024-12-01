import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/product_card_widget.dart'; // Import the ProductCardWidget

class ProductListPage extends StatelessWidget {
  final String categoryTitle;

  const ProductListPage({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for products (You can replace this with actual data)
    final products = [
      {
        'name': 'Product 1',
        'price': '\$10',
        'imagePath': 'assets/images/product1.png',
      },
      {
        'name': 'Product 2',
        'price': '\$15',
        'imagePath': 'assets/images/product2.png',
      },
      // Add more products as needed...
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF50B154), // Green AppBar
        title: Text(
          categoryTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.7, // Adjust aspect ratio for product cards
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCardWidget(
            name: product['name']!,
            price: product['price']!,
            imagePath: product['imagePath']!,
            onTap: () {
              // TODO: Handle product tap (e.g., navigate to product detail page)
            },
          );
        },
      ),
    );
  }
}
