import 'package:auto_route/auto_route.dart';
import 'package:canteen/presentation/navigation/app_router.dart';
import 'package:canteen/presentation/pages/home/products/product_list_page.dart';
import 'package:canteen/core/di.dart';
import 'package:canteen/core/mixins/dialog_helper.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/data/remote/auth_service.dart';
import 'package:canteen/presentation/navigation/app_router.gr.dart';
import 'package:canteen/presentation/providers/products_notifier.dart';
import 'package:canteen/presentation/widgets/buttons/app_button.dart';
import 'package:canteen/presentation/widgets/catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  bool isAdmin = true;

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
    final theme = Theme.of(context);
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
                    );
                    // context.router.pushNamed('/product-list');
                  },
                );
              },
            ),
          ),
        ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              const Spacer(),
              isAdmin
                  ? AppButton(
                color: AppColors.secondary,
                      title: 'Add category',
                      onPressed: () {
                        DialogHelper.showAddCategoryDialog(context);
                      },
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
