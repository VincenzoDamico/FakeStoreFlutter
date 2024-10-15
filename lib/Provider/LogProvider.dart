import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:store/model/object/Order_bucket.dart';

import '../model/object/Product.dart';
import '../model/object/User.dart';

class LogProvider extends ChangeNotifier{
  bool _log=false;

  bool get log=>_log;

  void LogIn() async{
    _log=true;
    notifyListeners();  // Notifica ai consumatori che lo stato è cambiato
  }

  void  LogOut()  async{
    _log=false;
    notifyListeners();
  }

  static LogProvider of(BuildContext context, {bool listen=true}){
    return Provider.of<LogProvider>(
      context,
      listen:listen,
    );
  }
}