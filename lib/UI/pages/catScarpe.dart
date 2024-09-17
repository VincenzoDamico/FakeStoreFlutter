import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../model/object/Categoria.dart';

import '../../model/Model.dart';
import '../../model/object/Product.dart';
import '../../model/support/constant.dart';
import '../widget/ProductCard.dart';

class catScarpe extends StatefulWidget {
  String categoria;
  catScarpe(this.categoria) : super();

  @override
  _catScarpeState createState() => _catScarpeState(categoria);
}

class _catScarpeState extends State<catScarpe> {
  bool _searching = true;
  List<Product>? _products;
  String categoria;

  _catScarpeState(this.categoria);

  @override
  Widget build(BuildContext context) {

    _search();
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Padding(
          padding: const EdgeInsets.all(Constants.pmd),
          child: Row(
            children: [
              // second column
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Constants.wfmax,
                  color: Colors.deepPurple[300],
                ),
              ),
              // First column
              Expanded(
                child: Column(
                  children: [
                    // youtube video

                    // comment section & recommended videos
                    Expanded(
                      child: !_searching
                          ? _products == null
                          ? SizedBox.shrink()
                          : _products!.length == 0
                          ? noResults()
                          : GridView.builder(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        itemCount: _products!.length,
                        // Generate 100 widgets that display their index in the List.
                        itemBuilder:
                            (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(
                                  Constants.pmd),
                              child: ProductCard(
                                  prod: _products![index]));
                        },

                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (screenSize.width -
                                Constants.wfmax) ~/
                                Constants.wmax,
                            childAspectRatio: Constants.wmax /
                                Constants.hmax),
                      )
                          : CircularProgressIndicator(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
  Widget noResults() {
    return Text("no_results !");
  }
  void _search() {
    if (_searching==true) {
      // Model.sharedInstance.getAllProduct()!.then((product) {
     Model.sharedInstance.getProductCategory(jsonEncode(Categoria(name:categoria, description:"")))!.then((product) {
        setState(() {
          _searching = false;
          _products = product;
        });
      });
    }
  }
}