import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Provider/ProductProvider.dart';
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

class CartScarpeD extends StatefulWidget {
  final String categoria;

  CartScarpeD(this.categoria) : super();

  @override
  _CartScarpeDState createState() => _CartScarpeDState(categoria);
}

class _CartScarpeDState extends State<CartScarpeD> {
  final String categoria;

  _CartScarpeDState(this.categoria);

  @override
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    _search(
        provider); // Spostato qui per evitare di chiamare il metodo più volte
  }

  @override
  Widget build(BuildContext context) {
    final provider = ProductProvider.of(context);
    var screenSize = MediaQuery.of(context).size;
    int num = (screenSize.width - MyConstant.wfmax) ~/ MyConstant.wmax;
    int numItemGrid = num < 1 ? 1 : num;
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Padding(
        padding: const EdgeInsets.all(MyConstant.pmd),
        child: Row(
          children: [
            // Colonna per il filtro
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
                  onApplyFilters: (selectedBrands) =>
                      _applyFilters(selectedBrands, provider), // Correzione qui
                ),
              ),
            ),
            // Colonna per i prodotti
            Expanded(
              child: Column(
                children: [
                  // GridView per visualizzare i prodotti
                  Expanded(
                    child: provider.search
                        ? Center(
                            child:
                                CircularProgressIndicator()) // Indicatore di caricamento
                        : provider.product == null || provider.product!.isEmpty
                            ? noResults() // Nessun risultato trovato
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: provider.product!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.all(MyConstant.pmd),
                                    child: ProductCard(
                                        prod: provider.product![index]),
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: numItemGrid,
                                  childAspectRatio:
                                      MyConstant.wmax / MyConstant.hmax,
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noResults() {
    return Center(child: Text("Nessun risultato trovato!"));
  }

  void _search(provider) {
    if (provider.search) {
      Model.sharedInstance.getProductCategory(categoria)!.then((product) {
        setState(() {
          provider.updateItem(lp: product);
        });
      }).catchError((error) {
        // Gestione dell'errore
        setState(() {
          provider.clear();
        });
        print("Errore durante la ricerca dei prodotti: $error");
      });
    }
  }

  void _applyFilters(
      Map<String, bool> selectedBrands, ProductProvider provider) {
    List<String> selectBrands = [];
    for (String key in selectedBrands.keys) {
      if (selectedBrands[key]!) {
        selectBrands.add(key);
      }
    }

    if (selectBrands.isEmpty) {
      // Nessun brand selezionato, mostra tutti i prodotti della categoria
      Model.sharedInstance.getProductCategory(categoria)!.then((product) {
        setState(() {
          provider.updateItem(lp: product);
        });
      }).catchError((error) {
        // Gestisci l'errore
        print("Errore durante la ricerca dei prodotti: $error");
      });
    } else {
      // Filtro applicato, mostra solo i prodotti dei brand selezionati
      Model.sharedInstance
          .getProductBrandCategory(categoria, selectBrands)!
          .then((product) {
        setState(() {
          provider.updateItem(lp: product);
        });
      }).catchError((error) {
        // Gestisci l'errore
        print("Errore durante la ricerca dei prodotti filtrati: $error");
      });
    }
  }
}
