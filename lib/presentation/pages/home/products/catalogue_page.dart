import 'package:auto_route/auto_route.dart';
import 'package:canteen/presentation/navigation/app_router.gr.dart';
import 'package:canteen/presentation/providers/products_notifier.dart';
import 'package:canteen/presentation/widgets/catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
