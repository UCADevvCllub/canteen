import 'package:canteen/features/products/domain/models/category.dart';
import 'package:canteen/features/products/domain/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsService {
  final _products = FirebaseFirestore.instance.collection('products');
  final _categories = FirebaseFirestore.instance.collection('categories');

  Future<List<Product>> getProducts() async {
    final snapshot = await _products.get();
    return snapshot.docs.map((doc) => Product.fromFirebase(doc)).toList();
  }

  Future<Product> getProductById(String id) async {
    final snapshot = await _products.doc(id).get();
    return Product.fromFirebase(snapshot);
  }

  // ----------------- Category -----------------

  Future<List<Category>> getCategories() async {
    final snapshot = await _categories.get();
    return snapshot.docs.map((doc) => Category.fromFirebase(doc)).toList();
  }

  Future<void> addCategory(Category category) async {
    await _categories.doc(category.id).set(category.toFirebase());
  }

  Future<void> updateCategory(Category category) async {
    await _categories.doc(category.id).update(category.toFirebase());
  }

  Future<void> deleteCategory(String id) async {
    await _categories.doc(id).delete();
  }
}
