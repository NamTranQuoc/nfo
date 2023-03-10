
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfo/entity/product.dart';

final db = FirebaseFirestore.instance.collection('product');

Future<void> addProduct(Product product) async {
  await db.add(product.toJson());
}

Future<List<Product>> getAllProduct() async {
  List<Product> product = [];
  await db
      .orderBy('created_date')
      .limit(10)
      .get()
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