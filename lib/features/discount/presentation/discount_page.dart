import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/navigation/app_router.gr.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class DiscountsPage extends StatelessWidget {
  const DiscountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/layouts/home_back.png', // Replace with your image path
              fit: BoxFit.cover, // Covers entire screen
            ),
          ),

          // Content on top of the background
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent, // Transparent AppBar
                elevation: 0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection(
                        context,
                        title: "Top Offers",
                        onSeeMore: () =>
                            context.router.push(const TopOffersRoute()),
                      ),
                      const SizedBox(height: 20),
                      _buildSection(
                        context,
                        title: "Most Popular",
                        onSeeMore: () =>
                            context.router.push(const MostPopularRoute()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: kToolbarHeight * 1.2,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                context.router.replace(const LoginRoute());
              },
              child: Image.asset(
                'assets/icons/menu.png',
                width: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required VoidCallback onSeeMore}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            TextButton(
              onPressed: onSeeMore,
              child:
              const Text("See more", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85), // Slight transparency
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: const Center(
              child: Text("Product list here",
                  style: TextStyle(color: Colors.black))),
        ),
      ],
    );
  }
}