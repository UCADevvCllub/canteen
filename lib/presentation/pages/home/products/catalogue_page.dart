import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/di.dart';
import 'package:canteen/core/mixins/dialog_helper.dart';
import 'package:canteen/data/auth/auth_service.dart';
import 'package:canteen/presentation/navigation/app_router.gr.dart';
import 'package:canteen/presentation/providers/products/products_notifier.dart';
import 'package:canteen/presentation/widgets/catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> with DialogHelper {
  bool isAdmin = true; // Change this to `false` if you don’t want admin access

  @override
  void initState() {
    // isAdminCheck();
    super.initState();
  }

  void isAdminCheck() async {
    locator<AuthService>().isAdmin().then((value) {
      setState(() {
        isAdmin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<ProductsNotifier>(
        builder: (context, provider, _) {
          final categories = provider.categories;
          return Column(
            children: [
              // Search Bar
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

              // Category Grid
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        // Navigate to product list
                        context.router.push(
                          ProductListRoute(categoryTitle: item.name),
                        );
                      },
                    );
                  },
                ),
              ),

              // Add Category Button (Only Visible to Admin)
              if (isAdmin)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEB8716), // Orange color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      minimumSize: const Size(332, 44),
                    ),
                    onPressed: () {
                      showAddCategoryDialog(context);
                    },
                    child: const Text(
                      "+ Add Category",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
