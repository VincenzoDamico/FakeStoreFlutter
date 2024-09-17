import 'package:flutter/cupertino.dart';
import 'package:store/model/support/constant.dart';

class ProductStyle {
  static final productShodow= BoxShadow(
    color: CupertinoColors.secondaryLabel,
    blurRadius: Constants.bR,
    spreadRadius: Constants.sR,
    offset: const Offset(0,2)

  );

}