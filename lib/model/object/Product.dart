import 'Brand.dart';
import 'Categoria.dart';
import 'Order_item.dart';

class Product {
  int? id;
  String name;
  int size;
  String color;
  String description;
  String image_path;
  int stock_quantity;

  double price;
  Categoria category;
  Brand brand;

  Product(
     { this.id,
      required this.name,
      required this.size,
      required this.color,
      required this.description,
       required this.image_path,
      required this.stock_quantity,
      required this.price,
      required this.category,
        required this.brand,
   });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          category.name == other.category.name &&
          brand.name == other.brand.name;


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      size: json['size'] as int,
      color: json['color'] as String,
      description: json['description'] as String,
      image_path: json['image_path'] as String,
      stock_quantity: json['stock_quantity'] as int,
        price: (json['price'] as num).toDouble(),
      category: Categoria.fromJson(json['category']),
      brand:  Brand.fromJson(json['brand']),

    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'size': size,
        'color': color,
        'description': description,
         'image_path': image_path,
        'stock_quantity': stock_quantity,
        'price': price,
        'category': category.toJson(),
        'brand': brand.toJson(),
      };

  @override
  String toString() {
    return name;
  }

  String getDescription() {
    return description;
  }

  String getImagePath() {
    return image_path;
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
