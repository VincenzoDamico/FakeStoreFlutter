/*
import 'Order_item.dart';
import 'Product.dart';
import 'User.dart';
import 'package:intl/intl.dart';

class Order_bucket {
  int? order_id;
  DateTime order_date;
  double total_price;
  List<Order_item> order_bucket;
  String usertoken;
  DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');


  Order_bucket({ this.order_id,required this.order_date, required this.total_price,required this.order_bucket,required this.usertoken});
  factory Order_bucket.fromJson(Map<String, dynamic> json) {
    return Order_bucket(
      order_id: json['order_id'],
      order_date: DateTime.parse(json['order_date']),
      total_price: json['total_price'],
      order_bucket: (json['order_bucket'] as List)
          .map((item) => Order_item.fromJson(item))
          .toList(),
      usertoken: json['usertoken'],
    );
  }

  Map<String, dynamic> toJson() => {

    'order_id': order_id,
    'order_date': formatter.format(order_date),
    'total_price': total_price,
    'order_bucket': order_bucket.map((item) => item.toJson()).toList(),
    'usertoken': usertoken,

  };

}*/
