import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/config/di.dart';
import 'package:canteen/core/mixins/dialog_helper.dart';
import 'package:canteen/features/auth/data/remote/auth_remote_service.dart';
import 'package:canteen/core/navigation/app_router.gr.dart';
import 'package:canteen/features/schedule/domain/presentation/provider/products_notifier.dart';
import 'package:canteen/features/schedule/domain/presentation/widgets/catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> with DialogHelper {
  bool isAdmin = false; // Default to false until checked
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredCategories = [];

  @override
  void initState() {
    isAdminCheck(); // Uncommented to fetch admin status dynamically
    super.initState();
    _searchController.addListener(_filterCategories);
  }

  void isAdminCheck() async {
    locator<AuthRemoteService>().isAdmin().then((value) {
      setState(() {
        isAdmin = value;
      });
    });
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    final provider = Provider.of<ProductsNotifier>(context, listen: false);
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = provider.categories;
      } else {
        _filteredCategories = provider.categories
            .where((category) => category.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCategories);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<ProductsNotifier>(
        builder: (context, provider, _) {
          if (_filteredCategories.isEmpty && _searchController.text.isEmpty) {
            _filteredCategories = provider.categories;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Adds vertical spacing above the title/icons row to push it lower
              const SizedBox(height: 60),

              // Title and Icons Row: Wrapped in a SizedBox to set a custom height
              SizedBox(
                height: 50, // Custom height for the title/icons row
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu icon and "Catalogue" title
                    Row(
                      children: [
                        // Menu icon
                        GestureDetector(
                          onTap: () {
                            // TODO: Add menu functionality (e.g., logout as in DiscountsPage)
                          },
                          child: Image.asset(
                            'assets/icons/menu.png',
                            width: 25,
                          ),
                        ),
                        const SizedBox(width: 10), // Space between icon and title
                        const Text(
                          'Catalogue',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Chat and Vector (Save) icons
                    Row(
                      mainAxisSize: MainAxisSize.min, // Take only the space needed
                      children: [
                        GestureDetector(
                          onTap: () {
                            // TODO: Add chat functionality
                          },
                          child: Image.asset(
                            'assets/icons/chat.png',
                            width: 25,
                          ),
                        ),
                        // Show the save icon only for non-admin users
                        if (!isAdmin) ...[
                          const SizedBox(width: 10), // Space between icons
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0), // Add padding to the right
                            child: GestureDetector(
                              onTap: () {
                                // TODO: Add save functionality
                                print("Save icon tapped");
                              },
                              child: Image.asset(
                                'assets/icons/Vector.png',
                                width: 25,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search product',
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: GridView.builder(
                  itemCount: _filteredCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.3,
                  ),
                  itemBuilder: (context, index) {
                    final item = _filteredCategories[index];
                    return CatalogWidget(
                      title: item.name,
                      imagePath: item.imageUrl,
                      onTap: () {
                        context.router.push(
                          ProductListRoute(categoryTitle: item.name),
                        );
                      },
                    );
                  },
                ),
              ),

              // Show the "Add Category" button only for admin users
              if (isAdmin)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEB8716),
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
                ),
            ],
          );
        },
      ),
    );
  }
}