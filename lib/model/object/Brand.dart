import 'Product.dart';

class Brand {
  String name;
  String email;
  String phone;
  String address;
  List<Product> prodotti;

  Brand({ required this.name,required this.email,required  this.phone,  required this.address, required this.prodotti});
  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      prodotti: (json['prodotti'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {

    'name': name,
    'email': email,
    'phone': phone,
    'address': address,
    'prodotti': prodotti.map((item) => item.toJson()).toList(),

  };

  @override
  String toString() {
    return name;
  }

}