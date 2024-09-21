import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/object/Brand.dart';
import '../../model/object/Categoria.dart';

import '../../model/Model.dart';
import '../../model/object/Product.dart';
import '../widget/ProductCard.dart';
import '../../model/support/MyConstant.dart';
import '../widget/FilterApp.dart';

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
        padding: const EdgeInsets.all(MyConstant.pmd),
        child: Row(
          children: [
            // second column
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MyConstant.wfmax,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.circular(MyConstant.bAm),
                ),
                  child: Filter(
                  categoria,
                  onApplyFilters: _applyFilters, // Passa il callback
                ),
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
                                    shrinkWrap: true,
                                    // Create a grid with 2 columns. If you change the scrollDirection to
                                    // horizontal, this produces 2 rows.
                                    itemCount: _products!.length,
                                    // Generate 100 widgets that display their index in the List.
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.all(
                                              MyConstant.pmd),
                                          child: ProductCard(
                                              prod: _products![index]));
                                    },

                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: (screenSize.width -
                                                    MyConstant.wfmax) ~/
                                                MyConstant.wmax,
                                            childAspectRatio: MyConstant.wmax /
                                                MyConstant.hmax),
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
    if (_searching == true) {
      // Model.sharedInstance.getAllProduct()!.then((product) {
      Model.sharedInstance
          .getProductCategory(
          categoria)!
          .then((product) {
        setState(() {
          _searching = false;
          _products = product;
        });
      });
    }
  }

  void _applyFilters(Map<String, bool> selectedBrands) {
    List<String> selectBrands=[];
    for (String key in selectedBrands.keys ){
      if(selectedBrands[key]!){
        selectBrands.add(key);
      }
    }

    if (selectBrands.isEmpty) {
      Model.sharedInstance
          .getProductCategory(
          categoria)!
          .then((product) {
        setState(() {
          _products = product;
        });
      });
    } else {
       Model.sharedInstance
            .getProductBrandCategory(
           categoria, selectBrands)!
            .then((product) {
          setState(() {
            _products = product;
          });
        });

    }
  }
}
