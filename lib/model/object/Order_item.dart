import 'Order_bucket.dart';
import 'Product.dart';

class Order_item {
  int? order_item_id;
  int quantity;
  Product prodotto;
  Order_bucket order_bucket;

  Order_item({ this.order_item_id,required this.quantity, required this.prodotto,required this.order_bucket});
  factory Order_item.fromJson(Map<String, dynamic> json) {
    return Order_item(
        order_item_id: json['order_item_id'],
        quantity: json['quantity'],
        prodotto: Product.fromJson(json['prodotto']),
        order_bucket: Order_bucket.fromJson(json['order_bucket']),
    );
  }

  Map<String, dynamic> toJson() => {

    'order_item_id': order_item_id,
    'quantity': quantity,
    'prodotto': prodotto.toJson(),
    'order_bucket': order_bucket.toJson(),
  };

}