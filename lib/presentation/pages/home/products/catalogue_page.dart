import 'package:auto_route/auto_route.dart';
import 'package:canteen/presentation/navigation/app_router.dart';
import 'package:canteen/presentation/navigation/app_router.gr.dart';
import 'package:canteen/presentation/pages/home/products/product_list_page.dart';
import 'package:canteen/presentation/providers/products_notifier.dart';
import 'package:canteen/presentation/widgets/catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final catalogItems = [
  {
    'title': 'Fruits and Veggies',
    'imagePath': 'assets/product_images/fruits_and_veggies.jpg'
  },
  {
    'title': 'Ready Meals',
    'imagePath': 'assets/product_images/ready_meals.jpg'
  },
  {
    'title': 'Instant Foods',
    'imagePath': 'assets/product_images/instant_foods.jpg'
  },
  {'title': 'Drinks', 'imagePath': 'assets/product_images/Drinks.jpg'},
  {
    'title': 'Bread and Pastries',
    'imagePath': 'assets/product_images/bread_and_pastries.jpg'
  },
  {
    'title': 'Tea and Coffee',
    'imagePath': 'assets/product_images/tea_and_coffee.jpg'
  },
  {
    'title': 'Chips and Snacks',
    'imagePath': 'assets/product_images/Chips_and_snacks.jpg'
  },
  {'title': 'Sausages', 'imagePath': 'assets/product_images/sausages.jpg'},
  {
    'title': 'Dairy Products and Eggs',
    'imagePath': 'assets/product_images/dairy_products_and_egss.jpg'
  },
  {'title': 'Sweets', 'imagePath': 'assets/product_images/sweets.jpg'},
  {
    'title': 'Canned Goods',
    'imagePath': 'assets/product_images/Canned_goods.jpg'
  },
  {'title': 'For Home', 'imagePath': 'assets/product_images/for_home.jpg'},
  {
    'title': 'Beauty and Hygiene',
    'imagePath': 'assets/product_images/beauty_and_hygiene.jpg'
  },
  {
    'title': 'Laundry and Cleaning',
    'imagePath': 'assets/product_images/laundry_and_cleaning.jpg'
  },
  {
    'title': 'Pasta, Cereals and Oil',
    'imagePath': 'assets/product_images/pasta_cereals_and_oil.jpg'
  },
  {
    'title': 'Miscellaneous',
    'imagePath': 'assets/product_images/miscellaneous.png'
  }, // Placeholder
];

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<ProductsNotifier>(
        builder: (context, provider, _) {
          final categories = provider.categories;
          return Column(
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
                    'Search product',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Grid for catalog items
              categories.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.3, // Adjust aspect ratio
                        ),
                        itemBuilder: (context, index) {
                          final item = categories[index];
                          return CatalogWidget(
                            title: item.name,
                            imagePath: item.imageUrl,
                            onTap: () {
                              // Navigate to ProductListPage with the selected category
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ProductListPage(
                              //       categoryTitle: item.name,
                              //     ),
                              //   ),
                              // );
                              context.router.push(
                                ProductListRoute(categoryId: item.id),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          );
        },
      ),
    );
  }
}
