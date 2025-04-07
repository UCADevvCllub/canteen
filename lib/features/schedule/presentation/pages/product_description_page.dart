import 'dart:ui';
import 'package:flutter/material.dart';

class ProductDescriptionPage extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  final String description;
  final double rating;
  final int reviews;

  const ProductDescriptionPage({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Product Image
            SizedBox(
              width: double.infinity,
              child: Container(
                color: const Color(
                    0xFF84C264), // Green background outside the image
                padding: const EdgeInsets.all(
                    16.0), // Padding to make the image smaller
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      20), // Rounded corners for the image
                  child: Image.asset(
                    imagePath, // Image path
                    fit: BoxFit.cover,
                    height: 200, // Adjust the image height
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            // Back Button
            _buildBackButton(context),
            // Scrollable Product Details Sheet
            _buildProductDetails(),
          ],
        ),
      ),
    );
  }

  // Back Button
  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Scrollable Product Details
  Widget _buildProductDetails() {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 1.0,
      minChildSize: 0.55,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag Handle
                _buildDragHandle(),
                // Product Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Price and Rating
                _buildPriceAndRating(),
                const SizedBox(height: 15),
                // Divider
                const Divider(thickness: 1, color: Colors.grey),
                const SizedBox(height: 10),
                // Description Title
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Product Description Text
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // Drag Handle
  Widget _buildDragHandle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Price and Rating Section
  Widget _buildPriceAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price Box
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9), // Light green background
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF50B154),
            ),
          ),
        ),
        // Star Rating and Reviews
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              rating.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '($reviews)',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
