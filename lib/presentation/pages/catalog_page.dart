import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/catalog_widget.dart'; // Import CatalogWidget
import 'package:canteen/presentation/pages/product_list_page.dart'; // Import ProductListPage

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of catalog items
    final catalogItems = [
      {'title': 'Fruits and Veggies', 'imagePath': 'assets/product_images/fruits_and_veggies.jpg'},
      {'title': 'Ready Meals', 'imagePath': 'assets/product_images/ready_meals.jpg'},
      {'title': 'Instant Foods', 'imagePath': 'assets/product_images/instant_foods.jpg'},
      {'title': 'Drinks', 'imagePath': 'assets/product_images/Drinks.jpg'},
      {'title': 'Bread and Pastries', 'imagePath': 'assets/product_images/bread_and_pastries.jpg'},
      {'title': 'Tea and Coffee', 'imagePath': 'assets/product_images/tea_and_coffee.jpg'},
      {'title': 'Chips and Snacks', 'imagePath': 'assets/product_images/Chips_and_snacks.jpg'},
      {'title': 'Sausages', 'imagePath': 'assets/product_images/sausages.jpg'},
      {'title': 'Dairy Products and Eggs', 'imagePath': 'assets/product_images/dairy_products_and_egss.jpg'},
      {'title': 'Sweets', 'imagePath': 'assets/product_images/sweets.jpg'},
      {'title': 'Canned Goods', 'imagePath': 'assets/product_images/Canned_goods.jpg'},
      {'title': 'For Home', 'imagePath': 'assets/product_images/for_home.jpg'},
      {'title': 'Beauty and Hygiene', 'imagePath': 'assets/product_images/beauty_and_hygiene.jpg'},
      {'title': 'Laundry and Cleaning', 'imagePath': 'assets/product_images/laundry_and_cleaning.jpg'},
      {'title': 'Pasta, Cereals and Oil', 'imagePath': 'assets/product_images/pasta_cereals_and_oil.jpg'},
      {'title': 'Miscellaneous', 'imagePath': 'assets/product_images/miscellaneous.png'}, // Placeholder
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light green background
      appBar: AppBar(
        backgroundColor: const Color(0xFF50B154), // Green AppBar
        elevation: 0,
        title: const Text(
          'Catalogue',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          // Placeholder for chat icon
          IconButton(
            icon: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Add chat functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Placeholder for search bar
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Text(
                  'Search product (placeholder)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Grid for catalog items
            Expanded(
              child: GridView.builder(
                itemCount: catalogItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.3, // Adjust aspect ratio
                ),
                itemBuilder: (context, index) {
                  final item = catalogItems[index];
                  return CatalogWidget(
                    title: item['title']!,
                    imagePath: item['imagePath']!,
                    onTap: () {
                      // Navigate to ProductListPage with the selected category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListPage(
                            categoryTitle: item['title']!,
                          ),
                        ),
                      );
                    },
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