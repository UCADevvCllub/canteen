import 'package:flutter/material.dart';
import 'package:canteen/presentation/pages/home/products/product_description_page.dart'; // Import the ProductDescriptionPage

class ProductCardWidget extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  final String description;
  final double rating;
  final int reviews;
  final VoidCallback onTap;


  const ProductCardWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.onTap, // Add this parameter
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Product Description Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDescriptionPage(
              name: name,
              price: price,
              imagePath: imagePath,
              description: description,
              rating: rating,
              reviews: reviews,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Product details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
