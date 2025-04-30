import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:canteen/core/widgets/fields/search_field.dart';
import 'package:canteen/features/products/presentation/provider/product_provider.dart'; // Add ProductProvider import

@RoutePage()
class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredProducts = []; // Store filtered products

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = provider.products; // Show all products if query is empty
      } else {
        _filteredProducts = provider.products
            .where((product) => product.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/layouts/home_back.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 30,
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .logout();
                              context.router.replace(const LoginRoute());
                            },
                            child: Image.asset(
                              'assets/icons/menu.png',
                              width: 25,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'Discounts',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        child: SearchField(
                          controller: _searchController,
                          hintFontSize: 14,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          showClearButton: false,
                          iconSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Container(
                height: 40,
                color: Colors.white,
                child: Marquee(
                  text: 'Shop is Open 🏠 Shop is Open 🏠 Shop is Open 🏠 ',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 20.0,
                  velocity: 50.0,
                  pauseAfterRound: const Duration(seconds: 1),
                  startPadding: 16.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.linear,
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<ProductProvider>(
                    builder: (context, provider, _) {
                      if (_filteredProducts.isEmpty &&
                          _searchController.text.isEmpty) {
                        _filteredProducts = provider.products;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSection(
                            context,
                            title: "Top Offers",
                            products: _filteredProducts,
                            onSeeMore: () =>
                                context.router.push(const TopOffersRoute()),
                          ),
                          const SizedBox(height: 20),
                          _buildSection(
                            context,
                            title: "Most Popular",
                            products: _filteredProducts,
                            onSeeMore: () =>
                                context.router.push(const MostPopularRoute()),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, {
        required String title,
        required List<dynamic> products,
        required VoidCallback onSeeMore,
      }) {
    final seeMoreColor = title == "Most Popular" ? Colors.black : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: title == "Most Popular" ? Colors.black : Colors.white,
              ),
            ),
            TextButton(
              onPressed: onSeeMore,
              child: Text(
                "See more",
                style: TextStyle(
                  color: seeMoreColor,
                  decoration: TextDecoration.underline,
                  decorationColor: seeMoreColor,
                  decorationThickness: 2.0,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: products.isEmpty
              ? const Center(
            child: Text(
              "No products found",
              style: TextStyle(color: Colors.black),
            ),
          )
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Placeholder for product image
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: product.imageUrl != null &&
                          product.imageUrl.isNotEmpty
                          ? Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                      )
                          : const Icon(Icons.image),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}