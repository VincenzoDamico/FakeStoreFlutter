import 'Product.dart';

class Categoria {
  String name;
  String? description;
 // List<Product>? prodottiC;

  Categoria({required this.name, this.description});
  factory Categoria.fromJson(Map<String, dynamic> json) {
  //  if (json['prodottiC'] != null) {
      return Categoria(
        name: json['name'] as String,
        description: json['description'] as String ); }/*,
        prodottiC: (json['prodottiC'] as List)
            .map((item) => Product.fromJson(item))
            .toList(),


    return Categoria(
        name: json['name'],
        description: json['description'] as String
        //,prodottiC: []
    );
  }
*/
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
    //    'prodottiC': prodottiC?.map((item) => item.toJson()).toList(),
      };

  @override
  String toString() {
    return '$name , $description';
  }
}
