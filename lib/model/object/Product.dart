import 'Brand.dart';
import 'Categoria.dart';
import 'Order_item.dart';

class Product {
  int? id;
  String name;
  int size;
  String color;
  String description;
  String imagePath;
  int stock_quantity;

  double price;
  Categoria category;
  Brand brand;
  List<Order_item> listOrder;

  Product(
     { this.id,
      required this.name,
      required this.size,
      required this.color,
      required this.description,
       required this.imagePath,
      required this.stock_quantity,
      required this.price,
      required this.category,
        required this.brand,
        required this.listOrder});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          category == other.category &&
          brand == other.brand;


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      size: json['size'] as int,
      color: json['color'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      stock_quantity: json['stock_quantity'] as int,
        price: (json['price'] as num).toDouble(),
      category: Categoria.fromJson(json['category']),
      brand:  Brand.fromJson(json['brand']),
      listOrder: (json['listOrder'] as List)
        .map((item) => Order_item.fromJson(item))
        .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'size': size,
        'color': color,
        'description': description,
         'image_path': imagePath,
        'stock_quantity': stock_quantity,
        'price': price,
        'category': category.toJson(),
        'brand': brand.toJson(),
        'listOrder': listOrder.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return name;
  }

  String getDescription() {
    return description;
  }

  String getImagePath() {
    return imagePath;
  }

  String getColor() {
    return color;
  }

  int getStockQuantity() {
    return stock_quantity;
  }

  double getPrice() {
    return price;
  }
  Categoria getCategory() {
    return category;
  }

  Brand getBrand() {
    return brand;
  }

  int getSize() {
    return size;
  }


}
