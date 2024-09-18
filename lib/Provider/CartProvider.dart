import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store/model/object/Order_bucket.dart';

import '../model/object/Order_item.dart';
import '../model/object/User.dart';

class CartProvider extends ChangeNotifier{
  List<Order_item> _orderItems=[];

  List<Order_item> get orderItems=>_orderItems;

  void addItem({ required Order_item newItem}) async{
    if (_orderItems.contains(newItem)) {
      // Se l'elemento esiste, incrementa la quantità
      var existingItem = _orderItems.firstWhere(
            (item) => item.prodotto == newItem.prodotto,
      );
      existingItem.addQuantity();  // Assicurati che `addQuantity` sia definito in Order_item
    } else {
      // Se l'elemento non esiste, aggiungilo al carrello
      _orderItems.add(newItem);
    }
    notifyListeners();  // Notifica ai consumatori che lo stato è cambiato
  }

  // Metodo per rimuovere un prodotto dal carrello
  void removeItem({ required Order_item item}) async{
    if(_orderItems.contains(item)) {
      item.removeQuantity();
      if(item.quantity==0)
        _orderItems.remove(item);
      notifyListeners();
    }// Notifica ai consumatori che lo stato è cambiato
  }
  void clear(){
    _orderItems.clear();
    notifyListeners();
  }

  // Metodo per ottenere il totale del carrello
  Future<double> getTotalPrice() async {
    double total = 0.0;
    for (var item in _orderItems) {
      total += item.prodotto.price*item.quantity;
    }
    return total;
  }

  static CartProvider of(BuildContext context, {bool listen=true}){
    return Provider.of<CartProvider>(
      context,
      listen:listen,
    );
  }
}