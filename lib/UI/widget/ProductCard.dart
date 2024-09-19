import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/CartProvider.dart';
import '../../model/object/Order_item.dart';
import '../../model/object/Product.dart';
import '../Aspect/ProductStyle.dart';
import '../../model/support/Images.dart';
import 'package:store/model/support/MyConstant.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.prod,
  });
  final Product prod;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [ProductStyle.productShodow],
              borderRadius: BorderRadius.circular(MyConstant.bAm),
              color: Colors.white),
          child: Column(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final double width = constraints.maxWidth;

                  final double height = width ; // Altezza 3/4 della larghezza

                  return Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(MyConstant.bAm),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Image.asset(
                      Images.myMap[prod.getImagePath()] ?? 'assets/images/default_image.png',
                      fit: BoxFit.contain, // Adatta l'immagine al contenitore
                    ),
                  );
                },
              ),
              const SizedBox(height: MyConstant.pmd),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prod.getBrand().toString(),
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        prod.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: MyConstant.pmd),
                      Row(children: [
                        Text(
                          '\€' + prod.getPrice().toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ), Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              context.read<CartProvider>().addItem(
                                  newItem: new Order_item(
                                      prodotto: prod, quantity: 1));
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: const Text("Copra")),
                      ])

                    ],
                  ))
            ],
          ),
        );
  }
}