
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfo/entity/product_type.dart';

class Product {
  String id;
  String name;
  double evaluate;
  List<String> images;
  List<ProductType> types;
  String description;
  bool isFeatured;
  DateTime createdDate;

  Product({
    this.id = '',
    this.name = '',
    this.evaluate = 0,
    required this.images,
    required this.types,
    this.description = '',
    this.isFeatured = false,
    required this.createdDate
  });

  Product.fromSnapshot(QueryDocumentSnapshot doc)
      : this(
      id: doc.id,
      name: doc['name']! as String,
      evaluate: doc['evaluate'] as double,
      images: (doc['images'] as List).cast<String>(),
      types: ((doc['types'] as List).cast<Map<String, Object?>>())
          .map((e) => ProductType.fromJson(e)).toList(),
      description: doc['description'] as String,
      isFeatured: doc['is_featured'] as bool,
      createdDate: (doc['created_date'] as Timestamp).toDate()
  );

  List<ProductType> toTypes(List<Map<String, Object>> data) {
    List<ProductType> pt = [];
    for (var element in data) {
      pt.add(ProductType.fromJson(element));
    }
    return pt;
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'evaluate': evaluate,
      'images': images,
      'types': types.map((e) => e.toJson()).toList(),
      'description': description,
      'is_featured': isFeatured,
      'created_date': createdDate
    };
  }
}