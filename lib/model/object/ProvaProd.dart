import 'Brand.dart';
import 'Categoria.dart';
import 'Order_item.dart';

class ProvaProd{
  int id;
  String name;
  int size;
  String color;
  String description;
  int stock_quantity;
  double price;
  Categoria category;
  Brand brand;
  List<Order_item>? listOrder;

  ProvaProd(
       this.id,
         this.name,
         this.size,
         this.color,
         this.description,
         this.stock_quantity,
         this.price,
        this.category,
         this.brand,
        this.listOrder);
  factory ProvaProd.fromJson(dynamic json) {
    if (json['listOrder'] != null) {
      var ObjsJson = json['listOrder'] as List;
      List<Order_item> _orders = ObjsJson.map((pJson) => Order_item.fromJson(pJson)).toList();
      return ProvaProd(
          json['id'] as int,
          json['description'] as String,
          json['size'] as int,
          json['color'] as String,
          json['description'] as String,
          json['stock_quantity'] as int,
          json['price'] as double,
          Categoria.fromJson(json['category']),
          Brand.fromJson(json['brand']),
          _orders
      );
    } else {
      return ProvaProd(
        json['id'] as int,
        json['description'] as String,
        json['size'] as int,
        json['color'] as String,
        json['description'] as String,
        json['stock_quantity'] as int,
        json['price'] as double,
          Categoria.fromJson(json['category']),
        Brand.fromJson(json['brand']),[]
      );
    }
  }
  @override
  String toString() {
    return name;
  }

}