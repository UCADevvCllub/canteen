import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/navigation/app_router.gr.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart'; // Import the marquee package
import 'package:provider/provider.dart';

@RoutePage()
class DiscountsPage extends StatefulWidget {
  const DiscountsPage({super.key});

  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
}

class _DiscountsPageState extends State<DiscountsPage> {
  // Controller to manage the search field's input
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add a listener to the search controller if you want to implement search functionality
    _searchController.addListener(() {
      // TODO: Add search functionality if needed (e.g., filter products)
    });
  }

  @override
  void dispose() {
    // Clean up the search controller to prevent memory leaks
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/layouts/home_back.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          Column(
            children: [
              // Custom AppBar with reduced height
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 30, // Reduced height to move the row higher
              ),

              // Row for menu icon, title, and search field, wrapped in SizedBox to control height
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Menu icon and "Discounts" title
                      Row(
                        children: [
                          // Menu icon with logout functionality
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
                          const SizedBox(
                              width: 20), // Space between icon and title
                          // "Discounts" title
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

                      // Interactive search field
                      //   SizedBox(
                      //     width: 200,
                      //     child: TextField(
                      //       controller: _searchController,
                      //       decoration: InputDecoration(
                      //         hintText: 'Search product',
                      //         hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      //         filled: true,
                      //         fillColor: Colors.white,
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(25),
                      //           borderSide: BorderSide.none,
                      //         ),
                      //         contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      //         prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),

              // "Shop is Open" marquee text with white background
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

              // Main content (Top Offers, Most Popular sections)
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
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required VoidCallback onSeeMore}) {
    // Determine the color for the "See more" button based on the section title
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
                color: title == "Most Popular"
                    ? Colors.black
                    : Colors
                        .white, // Black for "Most Popular", white for others
              ),
            ),
            TextButton(
              onPressed: onSeeMore,
              child: Text(
                "See more",
                style: TextStyle(
                  color:
                      seeMoreColor, // Black for "Most Popular", white for "Top Offers"
                  decoration: TextDecoration.underline, // Underline the text
                  decorationColor:
                      seeMoreColor, // Underline color matches the text color
                  decorationThickness: 2.0, // Make the underline more prominent
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
            child: Text("Product list here",
                style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}
