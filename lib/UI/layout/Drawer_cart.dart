import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Provider/CartProvider.dart';

import '../../model/support/Images.dart';

class Drawer_Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.orderItems;
    return Drawer(
        backgroundColor: Color(0xFAD3D3D7),
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        child: const Text(
                          "Pagemento",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.deepPurple),
                        ),
                        onPressed: () {}),
                    Spacer(),

                    FutureBuilder<double>(
                      future: provider.getTotalPrice(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Errore: ${snapshot.error}');
                        } else {
                          return Text(
                            '\$${snapshot.data?.toStringAsFixed(2) ?? '0.00'}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: finalList.length,
            itemBuilder: (context, index) {
              final cartItems = finalList[index];

              return Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                            height: 150,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            // padding: const EdgeInsets.all(20),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                  Images.myMap[cartItems.prodotto.imagePath]!),
                            )),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItems.prodotto.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              cartItems.prodotto.category.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey.shade400),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "\$${cartItems.prodotto.price}",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              FloatingActionButton(
                                  child: const Icon(Icons.add),
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .addItem(newItem: cartItems);
                                  }),
                              const SizedBox(height: 10),
                              Text(
                                "${cartItems.quantity}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              FloatingActionButton(
                                  child: const Icon(Icons.remove),
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .removeItem(item: cartItems);
                                  }),
                            ]))
                      ],
                    ),
                  ),
                ),
              ]);
            },
          ),
        ]));
  }
}
