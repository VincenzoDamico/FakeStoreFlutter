import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store/model/object/Order_bucket.dart';

import '../model/object/Product.dart';
import '../model/object/User.dart';

class ProductProvider extends ChangeNotifier{
  List<Product> _product=[];
  bool _search =true;

  List<Product> get product=>_product;
  bool get search=>_search;

  void updateItem({ required  List<Product> lp}) async{
     _product=lp;
    _search=false;
    notifyListeners();  // Notifica ai consumatori che lo stato è cambiato
  }

  void clear(){
    _product.clear();
    _search=true;
    notifyListeners();
  }

  static ProductProvider of(BuildContext context, {bool listen=true}){
    return Provider.of<ProductProvider>(
      context,
      listen:listen,
    );
  }
}