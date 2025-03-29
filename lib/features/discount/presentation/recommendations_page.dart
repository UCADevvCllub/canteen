import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/widgets/cards/discount_card_widget.dart';
import 'package:canteen/core/navigation/app_router.gr.dart';

@RoutePage()
class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF84C264),
      appBar: AppBar(
        title: const Text(
          "Discounts",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {}, // TODO: Add search functionality
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    '🏠 Shop is Open 🏠 Shop is Open 🏠',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _sectionHeader(context, 'Top Offers', const TopOffersRoute()),
              const SizedBox(height: 10),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const DiscountCardWidget(
                    imagePath: 'assets/images/sample_product.png',
                    title: 'Jin Ramen Mild',
                    oldPrice: '160 som',
                    newPrice: '48 som',
                    discount: '-30%',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _sectionHeader(context, 'Most Popular', const MostPopularRoute()),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => const DiscountCardWidget(
                    imagePath: 'assets/images/product over.png',
                    title: 'Jin Ramen Mild',
                    newPrice: '160 som',
                    showStar: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title, PageRouteInfo route) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        TextButton(
          onPressed: () => context.router.push(route),
          child: const Text('See more',
              style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}
