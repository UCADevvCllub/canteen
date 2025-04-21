import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String categoryId;
  final String? imageUrl;
  final int? quantity;
  final String? userType; // Added to match AddProductPage

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.categoryId,
    this.imageUrl,
    this.quantity,
    this.userType,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? categoryId,
    String? imageUrl,
    int? quantity,
    String? userType,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      userType: userType ?? this.userType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameOfProduct': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'userType': userType,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      categoryId: json['categoryId'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }

  factory Product.fromFirebase(DocumentSnapshot snap) {
    Map d = snap.data() as Map<String, dynamic>;
    return Product(
      id: d['id'] ?? snap.id,
      name: d['nameOfProduct'] ?? '',
      description: d['description'],
      price: (d['price'] ?? 0).toDouble(),
      categoryId: d['categoryId'] ?? '',
      imageUrl: d['imageUrl'],
      quantity: d['quantity'],
    );
  }
}