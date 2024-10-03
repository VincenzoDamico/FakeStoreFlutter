import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Provider/ProductProvider.dart';
import 'package:store/UI/pages/CartScarpeD.dart';
import 'package:store/UI/pages/CatScarpeM.dart';
import '../../Provider/CartProvider.dart';
import '../../model/object/Brand.dart';
import '../../model/object/Categoria.dart';

import '../../model/Model.dart';
import '../../model/object/Order_item.dart';
import '../../model/object/Product.dart';
import '../../model/support/Images.dart';
import '../widget/ProductCard.dart';
import '../../model/support/MyConstant.dart';
import '../widget/FilterApp.dart';

class CatScarpe extends StatefulWidget {
  final String categoria;

  CatScarpe({required this.categoria});

  @override
  _CatScarpeState createState() => _CatScarpeState();
}

class _CatScarpeState extends State<CatScarpe> {
  bool _isInitialized = false; // Traccia se è già stato eseguito clear()

  @override
  void initState() {
    super.initState();
    // Chiamiamo clear durante initState, che è il momento giusto per aggiornare lo stato
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        Provider.of<ProductProvider>(context, listen: false).clear();
        _isInitialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < MyConstant.mobileWidth) {
          return CartScarpeM(widget.categoria);
        } else {
          return CartScarpeD(widget.categoria);
        }
      },
    );
  }
}
