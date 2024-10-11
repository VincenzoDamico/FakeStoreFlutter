
import '../object/User.dart';

class UserRegistrationRequest{
  User user;
  String password;
  UserRegistrationRequest({required this.user, required this.password});



  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'password': password,
  };
  User getUser(){
    return user;
  }
}