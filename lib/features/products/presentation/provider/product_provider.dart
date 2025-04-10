import 'package:canteen/features/products/data/products_service.dart';
import 'package:canteen/features/products/domain/models/category.dart';
import 'package:flutter/material.dart';
import 'package:canteen/features/products/domain/models/product.dart';

// Добавьте импорт

class ProductProvider extends ChangeNotifier {
  final ProductsService _productsService;
  List<Product> _products = [];
  List<Category> _categories = [];
  bool _isLoading = false;

  ProductProvider(this._productsService) {
    // Измените конструктор
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

  getCategoryById(String id) {
    return _categories.firstWhere((category) => category.id == id);
  }
}
