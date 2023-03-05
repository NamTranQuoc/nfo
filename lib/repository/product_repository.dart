
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfo/entity/product.dart';

import '../entity/category.dart';

final db = FirebaseFirestore.instance.collection('product');

void addProduct(Product product) {
  db.add(product.toJson());
}

Future<List<Product>> getAllProduct() async {
  List<Product> product = [];
  await db.get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      product.add(Product.fromSnapshot(doc));
    }
  });
  return product;
}

Future<List<Product>> getFeaturedProduct() async {
  List<Product> product = [];
  await db.where("is_featured", isEqualTo: true).get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      product.add(Product.fromSnapshot(doc));
    }
  });
  return product;
}