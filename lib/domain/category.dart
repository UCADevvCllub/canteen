import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromFirebase(DocumentSnapshot snap) {
    Map d = snap.data() as Map<String, dynamic>;
    return Category(
      id: d['id'],
      name: d['name'],
      imageUrl: d['image_url'],
    );
  }
}