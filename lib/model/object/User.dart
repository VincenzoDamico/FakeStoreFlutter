class User {
  int? id;
  String name;
  String surname;
  String email;
  String phone;
  String address;
  String city;
  String cap;


  User({this.id,  required this.name, required this.surname,
    required this.email,required this.phone,required this.address,required this.city,required this.cap});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json["name"] as String,
      surname: json["surname"] as String,
      phone:json["phone"] as String,
      email:json["email"] as String,
      address: json["address"] as String,
      city: json["city"] as String,
      cap:json["cap"] as String);
  }


  Map<String, dynamic> toJson() => {
   'id': id,
    "name": name,
    "surname": surname,
    "email":email,
    "phone":phone,
    "address":address,
    "city":city,
    "cap":cap
  };

  @override
  String toString() {
    return name + " " + surname;
  }


}