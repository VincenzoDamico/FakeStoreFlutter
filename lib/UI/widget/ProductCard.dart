import 'package:flutter/material.dart';

import '../../model/object/Product.dart';
import '../Aspect/ProductStyle.dart';
import '../../model/support/Images.dart';
import '../../model/support/constant.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({super.key,
      required  this.prod,

  });
  final Product prod;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap:(){},
          child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              boxShadow: [ProductStyle.productShodow],
              borderRadius: BorderRadius.circular(Constants.bAm),
              color: Colors.white
          ),
          child: Column(
            children: [
            Container(
            padding: const EdgeInsets.all(Constants.pmd),
            height: Constants.himg,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Constants.bAm),
                border: Border.all(color: Colors.white)
              ),
            child: Image.asset(Images.myMap[prod.getImagePath()]!, fit: BoxFit.scaleDown),
            ),
          Padding(padding: const EdgeInsets.all(Constants.pmd),
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
              const SizedBox(height: Constants.pmd),
              Text(
                '\€'+prod.getPrice().toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineMedium,

              )
            ],
          ))

        ],
      ),

    )
    );


  }
}