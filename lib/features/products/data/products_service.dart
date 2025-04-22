import 'package:canteen/features/products/domain/models/category.dart';
import 'package:canteen/features/products/domain/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) => Product.fromFirebase(doc)).toList();
  }

  Future<List<Category>> getCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Category(
        id: doc.id,
        name: data['name'] ?? '',
        imageUrl: data['image_url'] ?? '',
      );
    }).toList();
  }

  Future<List<Product>> getProductsByCategory(String categoryId) async {
    if (categoryId.isEmpty) {
      return getProducts();
    }
    final snapshot = await _firestore
        .collection('products')
        .where('categoryId', isEqualTo: categoryId)
        .get();
    return snapshot.docs.map((doc) => Product.fromFirebase(doc)).toList();
  }

  Future<void> addProduct(Product product) async {
    await _firestore
        .collection('products')
        .doc(product.id)
        .set(product.toJson());
  }
}
