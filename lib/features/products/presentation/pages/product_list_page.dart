import 'package:auto_route/auto_route.dart';
import 'package:canteen/features/products/presentation/provider/product_provider.dart';
import 'package:canteen/core/widgets/cards/product_card_widget.dart';
import 'package:canteen/features/products/presentation/pages/add_product_page.dart';
import 'package:canteen/features/products/domain/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:canteen/core/widgets/fields/search_field.dart';
import 'package:canteen/core/data/service/user_service.dart'; // ✅ Added UserService import

@RoutePage()
class ProductListPage extends StatefulWidget {
  final String categoryId;

  const ProductListPage({super.key, @PathParam('categoryId') required this.categoryId});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  String _selectedCategoryId = '';
  bool? isAdmin; // ✅ Track admin status

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.categoryId;
    _searchController.addListener(_filterProducts);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _loadUserRole(); // ✅ Load user role from UserService

    print('Category ID: ${widget.categoryId}');
    print('Loading background image: assets/images/product over.png');
  }

  Future<void> _loadUserRole() async {
    await UserService().loadUserData();
    setState(() {
      isAdmin = UserService().isAdmin();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = provider.products;
      } else {
        _filteredProducts = provider.products
            .where((product) => product.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _showAddProductModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddProductPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAdmin == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/product over.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Consumer<ProductProvider>(
            builder: (context, provider, _) {
              String title;
              if (_selectedCategoryId.isEmpty) {
                title = 'All Products';
              } else {
                title = provider.categories
                    .firstWhereOrNull(
                        (category) => category.id == _selectedCategoryId)
                    ?.name ??
                    'Products';
              }
              return Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            },
          ),
          actions: [
            if (isAdmin!) ...[
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 25),
                onPressed: () => _showAddProductModal(context),
              ),
            ],
            IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.white, size: 25),
              onPressed: () {
                // TODO: Save action
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ProductProvider>(
            builder: (context, provider, _) {
              if (_filteredProducts.isEmpty && _searchController.text.isEmpty) {
                _filteredProducts = provider.products;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SearchField(controller: _searchController),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip(context, provider, 'ALL', ''),
                        ...provider.categories.map((category) =>
                            _buildCategoryChip(context, provider, category.name, category.id)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder(
                      future: provider.getProductsByCategory(
                          _selectedCategoryId.isEmpty
                              ? widget.categoryId
                              : _selectedCategoryId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'Error loading products.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        final products = snapshot.data!;
                        return GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCardWidget(product: product);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
      BuildContext context, ProductProvider provider, String name, String id) {
    bool isSelected = _selectedCategoryId == id;
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategoryId = isSelected ? '' : id;
          });
        },
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                height: 2,
                width: 20,
                color: const Color(0xFF50B154),
              ),
          ],
        ),
      ),
    );
  }
}
