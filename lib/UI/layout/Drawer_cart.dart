import 'package:flutter/material.dart';
import 'package:store/Provider/CartProvider.dart';

import '../../model/support/Images.dart';

class Drawer_Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.orderItems;
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
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 80.0, // You can adjust the size as needed
                ),
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
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$${cartItems.quantity}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(onPressed: onPressed, icon: ),
                              IconButton(onPressed: onPressed, icon: icon),

                            ]
                        )
                      ],
                    ),
                  ),
                ),
              ]);
            },
          ),
        ],
      ),
    );
  }
}
