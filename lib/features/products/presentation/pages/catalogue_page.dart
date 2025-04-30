import 'package:auto_route/auto_route.dart';
import 'package:canteen/features/products/presentation/provider/product_provider.dart';
import 'package:canteen/features/products/presentation/widgets/catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canteen/core/widgets/fields/search_field.dart';
import 'package:canteen/features/products/presentation/widgets/utils/add_category_dialog_widget.dart';
import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/features/profile/presentation/pages/profile_page.dart'; // Import ProfilePage

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  bool? isAdmin;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCategories);
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    await UserService().loadUserData();
    setState(() {
      isAdmin = UserService().isAdmin();
    });
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    final provider = Provider.of<ProductProvider>(context, listen: false);
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

  void showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AddCategoryDialogWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAdmin == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (_filteredCategories.isEmpty && _searchController.text.isEmpty) {
            _filteredCategories = provider.categories;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()),
                          );
                        },
                        child: Image.asset('assets/icons/menu.png', width: 25),
                      ),
                      const SizedBox(width: 10),
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
                  Row(
                    children: [
                      Image.asset('assets/icons/chat.png', width: 25),
                      if (!isAdmin!) ...[
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => print("Save icon tapped"),
                          child: Image.asset('assets/icons/Vector.png', width: 25),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SearchField(controller: _searchController),
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
                          ProductListRoute(categoryId: item.id),
                        );
                      },
                    );
                  },
                ),
              ),
              if (isAdmin!)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () => showAddCategoryDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEB8716),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        minimumSize: const Size(332, 44),
                      ),
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