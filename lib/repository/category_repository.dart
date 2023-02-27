
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/category.dart';

final db = FirebaseFirestore.instance.collection('category');

void addCategory(Category category) {
  db.add(category.toJson());
}

Future<List<Category>> getAllCategory() async {
  List<Category> category = [];
  await db.get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      category.add(Category(id: doc.id, name: doc["name"]));
    });
  });
  return category;
}