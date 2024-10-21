import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Provider/CartProvider.dart';
import 'package:store/Provider/LogProvider.dart';
import 'package:store/model/Model.dart';
import 'package:store/model/object/Order_item.dart';

import '../../model/support/Images.dart';
import '../pages/LoginPage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Provider/CartProvider.dart';
import 'package:store/Provider/LogProvider.dart';
import 'package:store/model/Model.dart';
import '../../model/support/Images.dart';
import '../pages/LoginPage.dart';

class DrawerCart extends StatefulWidget {
  @override
  _DrawerCartState createState() => _DrawerCartState();
}

class _DrawerCartState extends State<DrawerCart> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context, listen: false);
    final finalList = provider.orderItems;
    LogProvider logProvider = LogProvider.of(context);

    return Drawer(
      backgroundColor: Color(0xFAD3D3D7),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
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
                          "Pagamento",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.deepPurple),
                        ),
                        onPressed: () async {
                          if (!logProvider.log) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Impossibile Pagamento'),
                                  content: Text(
                                      'Impossibile effettuare il pagamento, devi fare prima il log in'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Loginpage()));
                          } else {
                            if (!finalList.isEmpty) {
                              bool aq = true;
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Conferma l\'acquisto'),
                                    content: Text('Sei sicuro?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Si',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.green)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          aq = false;
                                        },
                                        child: Text('No',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (aq) {
                                bool purchase = await Model.sharedInstance
                                    .purchase(finalList);
                                print(purchase.toString());
                                if (purchase) {
                                  setState(() => provider.clear());
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('c\'è l\'hai fatta'),
                                        content: Text(
                                            'Ordine effetuato con successo'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            }
                          }
                        }),
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
              return Stack(
                children: [
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
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.asset(Images
                                        .myMap[cartItems.product.image_path] ??
                                    'assets/images/defaultImage.png'),
                              )),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItems.product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                cartItems.product.category.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey.shade400),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "\$${cartItems.product.price}",
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
                                      setState(() {
                                        context
                                            .read<CartProvider>()
                                            .addItem(newItem: cartItems);
                                      });
                                    }),
                                const SizedBox(height: 10),
                                Consumer<CartProvider>(
                                  builder: (context, cartProvider, child) {
                                    return Text(
                                      "${cartProvider.getQuantItem(item: cartItems)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                FloatingActionButton(
                                    child: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        context
                                            .read<CartProvider>()
                                            .removeItem(item: cartItems);
                                      });
                                    }),
                              ]))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
