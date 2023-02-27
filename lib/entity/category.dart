
class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name
  });

  Category.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}