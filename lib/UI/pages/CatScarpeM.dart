import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/CartProvider.dart';
import '../../Provider/ProductProvider.dart';
import '../../model/object/Brand.dart';
import '../../model/object/Categoria.dart';

import '../../model/Model.dart';
import '../../model/object/Order_item.dart';
import '../../model/object/Product.dart';
import '../../model/support/Images.dart';
import '../widget/ProductCard.dart';
import '../../model/support/MyConstant.dart';
import '../widget/FilterApp.dart';

class CartScarpeM extends StatefulWidget {
  final String categoria;
  CartScarpeM(this.categoria) : super();

  @override
  _CartScarpeMState createState() => _CartScarpeMState(categoria);
}

class _CartScarpeMState extends State<CartScarpeM> {
  final String categoria;

  _CartScarpeMState(this.categoria);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ProductProvider>(context, listen: true);

    _search(provider); // Spostato qui per evitare di chiamare il metodo più volte
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Padding(

        padding: const EdgeInsets.all(MyConstant.pmd),
        child: Column(
          children: [

            Container(
                  width: double.infinity,
                  color: Colors.deepPurple[400],
                          child: Filter(
                            categoria,
                            onApplyFilters: (selectedBrands) => _applyFilters(selectedBrands, provider), // Correzione qui
                          ),
                        ),


            // comment section & recommended videos
            Expanded(
              child: !provider.search
                  ? provider.product == null
                      ? SizedBox.shrink()
                      : provider.product!.length == 0
                          ? noResults()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.product!.length,
                              itemBuilder: (context, index) {
                                final cartItems = provider.product![index];

                                return Stack(children: [
                                  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(20),
                                        child: Row(children: [
                                          Container(
                                              height: 150,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                              // padding: const EdgeInsets.all(20),
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Image.asset(Images.myMap[
                                                    cartItems.imagePath]!),
                                              )),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartItems.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                cartItems.category.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "\$${cartItems.price}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<CartProvider>()
                                                          .addItem(
                                                              newItem:
                                                                  new Order_item(
                                                                      prodotto:
                                                                          cartItems,
                                                                      quantity:
                                                                          1));
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    icon: const Icon(Icons.add))
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ))
                                ]);
                              },
                            )
                  : CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }

  Widget noResults() {
    return Text("no_results !");
  }

  void _search(ProductProvider provider) {
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

  void _applyFilters(Map<String, bool> selectedBrands, ProductProvider provider) {
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
