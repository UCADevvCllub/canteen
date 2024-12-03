import 'package:auto_route/annotations.dart';
import 'package:canteen/presentation/providers/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:canteen/presentation/widgets/cards/product_card_widget.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProductListPage extends StatelessWidget {
  final String categoryId;

  const ProductListPage({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsNotifier>(
      builder: (context, provider, _) {
        final category = provider.getCategoryById(categoryId);
        final products = provider.products
            .where((product) => product.categoryId == categoryId)
            .toList();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF50B154), // Green AppBar
            title: Text(
              category.name,
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
                product: product,
              );
            },
          ),
        );
      },
    );
  }
}
