import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String title;
  final num price;
  final String id;
  final List<dynamic> imageUrl;
  final String description;
  final String category;
  final DateTime? dateOfUpload;

  Product(
      {required this.title,
      required this.id,
      required this.category,
      required this.price,
      required this.imageUrl,
      required this.description,
      this.dateOfUpload});

  factory Product.fromJson(json) => Product(
      title: json['title'],
      id: json['id'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['about'],
      dateOfUpload: (json['dateOfUpload'] as Timestamp).toDate());

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'category': category,
        'imageUrl': imageUrl,
        'about': description,
        'price': price,
        'dateOfUpload': DateTime.now()
      };
}
