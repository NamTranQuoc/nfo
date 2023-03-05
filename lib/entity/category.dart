
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name
  });

  Category.fromSnapshot(QueryDocumentSnapshot doc)
      : this(
    id: doc.id,
    name: doc['name']! as String
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}