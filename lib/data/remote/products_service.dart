import 'package:canteen/domain/category.dart';
import 'package:canteen/domain/product.dart';
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

  Future<List<Category>> getCategories() async {
    final snapshot = await _categories.get();
    return snapshot.docs.map((doc) => Category.fromFirebase(doc)).toList();
  }
}