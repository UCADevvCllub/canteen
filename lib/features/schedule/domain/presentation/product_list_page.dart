import 'package:auto_route/annotations.dart';
import 'package:canteen/features/products/domain/models/product.dart';
import 'package:flutter/material.dart';
import 'package:canteen/core/widgets/cards/product_card_widget.dart';
import 'package:canteen/features/schedule/domain/presentation/product_description_page.dart';


@RoutePage()
class ProductListPage extends StatelessWidget {
  final String categoryTitle;

  const ProductListPage({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    // Mock products data for the selected category
    final products = [
      {
        'name': 'Jin Ramen Mild',
        'price': '160 som/piece',
        'imagePath': 'assets/product_images/jin_ramen.jpg',
        'description': 'Delicious Korean-style ramen with a mild flavor.',
        'rating': 4.5,
        'reviews': 13,
      },
      {
        'name': 'Jin Ramen Spicy',
        'price': '170 som/piece',
        'imagePath': 'assets/product_images/jin_ramen_spicy.jpg',
        'description': 'Delicious Korean-style ramen with a spicy kick.',
        'rating': 4.8,
        'reviews': 20,
      },
      {
        'name': 'Cup Noodles',
        'price': '120 som/piece',
        'imagePath': 'assets/product_images/cup_noodles.jpg',
        'description': 'Convenient cup noodles for quick meals on the go.',
        'rating': 4.3,
        'reviews': 8,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: const Color(0xFF50B154),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCardWidget(
            name: product['name'] as String,
            // Explicitly cast as String
            price: product['price'] as String,
            // Explicitly cast as String
            imagePath: product['imagePath'] as String,
            // Explicitly cast as String
            description: product['description'] as String,
            // Explicitly cast as String
            rating: product['rating'] as double,
            // Explicitly cast as double
            reviews: product['reviews'] as int,
            // Explicitly cast as int
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDescriptionPage(
                    name: product['name'] as String,
                    price: product['price'] as String,
                    imagePath: product['imagePath'] as String,
                    description: product['description'] as String,
                    rating: product['rating'] as double,
                    reviews: product['reviews'] as int,
                  ),
                ),
              );
            },
            product: Product(
              name: product['name'] as String,
              categoryId: '',
              id: '',

              // Explicitly cast as String
              price: product['price'] as double,
              // Explicitly cast as String
              description: product['description'] as String,
              // Explicitly cast as String
              // Explicitly cast as double
              // Explicitly cast as int
            ),
          );
        },
      ),
    );
  }
}
