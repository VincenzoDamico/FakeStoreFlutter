
class Categoria {
  String name;
  String? description;

  Categoria({required this.name, this.description});
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
        name: json['name'] as String,
        description: json['description'] as String);
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };

  @override
  String toString() {
    return '$name , $description';
  }
}
