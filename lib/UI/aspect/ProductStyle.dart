import 'package:flutter/cupertino.dart';
import 'package:store/model/support/MyConstant.dart';

class ProductStyle {
  static final productShodow= BoxShadow(
    color: CupertinoColors.secondaryLabel,
    blurRadius: MyConstant.bR,
    spreadRadius: MyConstant.sR,
    offset: const Offset(0,2)

  );

}