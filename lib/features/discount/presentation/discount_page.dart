import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/navigation/app_router.gr.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:canteen/core/widgets/fields/search_field.dart'; // Import the SearchField widget

@RoutePage()
class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {});
  }

  @override
  void dispose() {
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
                              Provider.of<AuthProvider>(context, listen: false).logout();
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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection(
                        context,
                        title: "Top Offers",
                        onSeeMore: () => context.router.push(const TopOffersRoute()),
                      ),
                      const SizedBox(height: 20),
                      _buildSection(
                        context,
                        title: "Most Popular",
                        onSeeMore: () => context.router.push(const MostPopularRoute()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required VoidCallback onSeeMore}) {
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
          child: const Center(
            child: Text("Product list here", style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}