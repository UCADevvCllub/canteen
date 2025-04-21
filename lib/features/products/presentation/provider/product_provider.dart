import 'package:canteen/features/products/data/products_service.dart';
import 'package:canteen/features/products/domain/models/category.dart';
import 'package:flutter/material.dart';
import 'package:canteen/features/products/domain/models/product.dart';

class ProductProvider extends ChangeNotifier {
  final ProductsService _productsService;
  List<Product> _products = [];
  List<Category> _categories = [];
  bool _isLoading = false;

  ProductProvider(this._productsService) {
    _initialize();
  }

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait([fetchProducts(), fetchCategories()]);
    } catch (e) {
      print('Error initializing data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    try {
      _products = await _productsService.getProducts();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      _categories = await _productsService.getCategories();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      return await _productsService.getProductsByCategory(categoryId);
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _productsService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }

  Category getCategoryById(String id) {
    return _categories.firstWhere(
          (category) => category.id == id,
      orElse: () => Category(id: id, name: 'Unknown', imageUrl: ''),
    );
  }
}