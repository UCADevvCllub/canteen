import 'package:auto_route/auto_route.dart';
import 'package:canteen/core/config/di.dart';
import 'package:canteen/core/navigation/app_router.gr.dart' hide AddCategoryDialogWidget;
import 'package:canteen/features/auth/data/remote/auth_remote_service.dart';
import 'package:canteen/features/products/presentation/provider/product_provider.dart';
import 'package:canteen/features/products/presentation/widgets/catalog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:canteen/core/widgets/fields/search_field.dart'; // Import the SearchField widget
import 'package:canteen/core/widgets/layout/add_category_dialog_widget.dart';

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
    _checkAdmin();
  }

  void _checkAdmin() async {
    setState(() {
      isAdmin = true;
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
            .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
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
      builder: (BuildContext context) {
        return const AddCategoryDialogWidget();
      },
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

              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/menu.png',
                            width: 25,
                          ),
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
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/chat.png',
                            width: 25,
                          ),
                        ),
                        if (isAdmin == false) ...[
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              print("Save icon tapped");
                            },
                            child: Image.asset(
                              'assets/icons/Vector.png',
                              width: 25,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
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

              if (isAdmin == true)
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