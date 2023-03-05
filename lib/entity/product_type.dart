
class ProductType {
  String name;
  int price;
  int quantity;

  ProductType({
    this.name = '',
    this.price = 0,
    this.quantity = 0
  });

  ProductType.fromJson(Map<String, Object?> json)
      : this(
    name: json['name'] as String,
    price: json['price'] as int,
    quantity: json['quantity'] as int
  );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity
    };
  }
}