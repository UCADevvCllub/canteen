import 'package:auto_route/auto_route.dart';
import 'package:canteen/presentation/widgets/cards/discount_card_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF84C264), // Background color from design
      appBar: AppBar(
        backgroundColor: const Color(0xFF84C264),
        elevation: 0,
        title: const Text(
          'Discounts',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Announcement Bar
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '🏠 Shop is Open 🏠 Shop is Open 🏠',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Top Offers Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Offers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to see all offers
                  },
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 220, // Height for scrollable product list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Sample data count
                itemBuilder: (context, index) {
                  return const DiscountCardWidget(
                    imagePath: 'assets/product_images/jin_ramen.png',
                    title: 'Jin Ramen Mild',
                    oldPrice: '160 som',
                    newPrice: '48 som',
                    discount: '-30%',
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Most Popular Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Most Popular',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to see all popular products
                  },
                  child: const Text(
                    'See more',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return const DiscountCardWidget(
                    imagePath: 'assets/product_images/jin_ramen.png',
                    title: 'Jin Ramen Mild',
                    newPrice: '160 som',
                    showStar: true, // Show star rating
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
