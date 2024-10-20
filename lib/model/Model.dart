import 'dart:async';
import 'dart:convert';

import 'package:store/model/object/Brand.dart';
import 'package:store/model/object/Order_bucket.dart';
import 'package:store/model/support/AuthenticationData.dart';
import 'package:store/model/support/LogInResult.dart';
import 'package:store/model/support/MyConstant.dart';
import 'package:store/model/support/UserRegistrationRequest.dart';
import 'menager/RestManager.dart';
import 'object/Order_item.dart';
import 'object/Product.dart';
import 'object/User.dart';



class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();

  AuthenticationData? _authenticationData;


  Future<LogInResult> logIn(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = MyConstant.CLIENT_ID;
      params["client_secret"] = MyConstant.CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      String result = await _restManager.makePostRequest(MyConstant.ADDRESS_AUTHENTICATION_SERVER, MyConstant.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData!.hasError() ) {
        if ( _authenticationData!.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _authenticationData!.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData!.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData!.expiresIn - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }

  }

  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = MyConstant.CLIENT_ID;
      params["client_secret"] = MyConstant.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData!.refreshToken;
      String result = await _restManager.makePostRequest(MyConstant.ADDRESS_AUTHENTICATION_SERVER, MyConstant.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData!.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData!.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = null;
      params["client_id"] = MyConstant.CLIENT_ID;
      params["client_secret"] = MyConstant.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData!.refreshToken;
      await _restManager.makePostRequest(MyConstant.ADDRESS_AUTHENTICATION_SERVER, MyConstant.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }
  Future<bool> purchase(List<Order_item> li) async {
    if (_restManager.token!=null) {
      Map<String, String> params = Map();
      params["Authorization"]="Bearer "+_restManager.token!;
      String result = await _restManager.makePostRequestAuthorization(MyConstant.ADDRESS_STORE_SERVER, MyConstant.REQUEST_PURCHASE, params, li);
      print(result);
      return result=="CART_UPDATED";
    }
    return false;
  }




    Future<List<Product>> getAllProduct() async {
      List<dynamic> ObjsJson= jsonDecode(await _restManager.makeGetRequest(
          MyConstant.ADDRESS_STORE_SERVER,
          MyConstant.REQUEST_ALL_PRODUCTS)) as List;
      List<Product> pObjs = ObjsJson.map((pObjs) => Product.fromJson(pObjs)).toList();
      if (pObjs==null){
        print("errorooror");
      }
      return pObjs;

  }
  Future<List<Product>?> getProductCategory(String c) async {
    print(" \n richiestaProdCat \n");

    Map<String, String> params = Map();
    params["catname"] = c;
    List<dynamic> ObjsJson= jsonDecode(await _restManager.makeGetRequest(
        MyConstant.ADDRESS_STORE_SERVER,
        MyConstant.REQUEST_CATEGORY_PRODUCTS,params)) as List;
    if (ObjsJson.isEmpty){
      return null;
    }
    List<Product> pObjs = ObjsJson.map((data) => Product.fromJson(data)).toList();
    return pObjs;

  }
  Future<List<Product>> getProductBrandCategory(String c, List<String> brands) async {
    Map<String, String> params = Map();
    params["catname"] = c;
    params["brands"] = brands.toString().replaceAll("[", "").replaceAll("]", "");;
    List<dynamic> ObjsJson= jsonDecode(await _restManager.makeGetRequest(
        MyConstant.ADDRESS_STORE_SERVER,
        MyConstant.REQUEST_PRODUCTS_CATEGORY_BRANDS,params)) as List;
    List<Product> bObjs = ObjsJson.map((data) => Product.fromJson(data)).toList();

    if (bObjs==null){
      print("errorooror");
    }
    return bObjs;
  }




  Future<List<Brand>?>? getBrandCategory(String c) async {
    Map<String, String> params = Map();
    params["category"] = c;
    List<dynamic> ObjsJson= jsonDecode(await _restManager.makeGetRequest(
        MyConstant.ADDRESS_STORE_SERVER,
        MyConstant.REQUEST_CATEGORY_BRANDS,params)) as List;
    if (ObjsJson.isEmpty){
      return null;
    }
    List<Brand> bObjs = ObjsJson.map((data) => Brand.fromJson(data)).toList();


    return bObjs;
  }

/* Future<List<Product>?>? searchProduct(String name) async {
    Map<String, String> params = Map();
    params["name"] = name;
    try {
      return List<Product>.from(json.decode(await _restManager.makeGetRequest(
          Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_PRODUCTS,
          params)).map((i) => Product.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }

  Future<List<User>?> getAllUser() async {
    Map<String, String> params = Map();
    try {
      return List<User>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_PRODUCTS, params)).map((i) => User.fromJson(i)).toList());
    }
    catch (e) {
      return null; // not the best solution
    }
  }*/

  Future<User?>? addUser(User user, String password) async {
    UserRegistrationRequest s=new UserRegistrationRequest(user: user,password: password);
    try {
      String rawResult = await _restManager.makePostRequest(MyConstant.ADDRESS_STORE_SERVER, MyConstant.REQUEST_ADD_USER, s);
      if ( rawResult.contains(MyConstant.RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS) ) {
        return null; // not the best solution
      }
      else {
        return User.fromJson(jsonDecode(rawResult));
      }
    }
    catch (e) {
      return null; // not the best solution
    }
  }


}
