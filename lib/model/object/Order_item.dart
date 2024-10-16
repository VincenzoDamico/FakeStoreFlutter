import 'Order_bucket.dart';
import 'Product.dart';

class Order_item {
  // Campo statico per tracciare l'ID progressivo
  static int _currentId = 0;

  int order_item_id;
  int quantity = 0;
  Product product;
  //Order_bucket? order_bucket;

  // Costruttore
  Order_item({
    required this.quantity,
    required this.product,
   // this.order_bucket,
  }) : order_item_id = _generateId();  // Genera un nuovo ID automaticamente

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Order_item &&
              runtimeType == other.runtimeType &&
              product == other.product;

  // Genera un nuovo ID incrementale
  static int _generateId() {
    _currentId++;
    return _currentId;
  }

  // Metodo fromJson per creare un Order_item da JSON
  factory Order_item.fromJson(Map<String, dynamic> json) {
    return Order_item(
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
   //   order_bucket: Order_bucket.fromJson(json['order_bucket']),
    );
  }

  // Convertire l'Order_item in JSON
  Map<String, dynamic> toJson() => {
    'order_item_id': order_item_id,
    'quantity': quantity,
    'product': product.toJson(),
   // 'order_bucket': order_bucket?.toJson(),
  };

  // Aumenta la quantità, verificando che non superi lo stock
  void addQuantity() {
    if (product.stock_quantity > quantity) {
      quantity++;
    }
  }

  // Riduci la quantità
  void removeQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }
}



