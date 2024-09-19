import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/ProductCard.dart';
import 'widget/FilterApp.dart';
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';
    var screenSize = MediaQuery.of(context).size;
    final List<String> entries = <String>['A', 'B', 'C'];
    /*24 is for notification bar on Android*/
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(title: const Text('sito UI')),
        body:
            Row(
            children: [
              Container(
                width: 200,
                height: double.infinity,
                child:  ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                          return RadioExampleApp()
                          ;
                    }
                ),

            ), Container(
              width:screenSize.width>450 ? (screenSize.width- 200):300,
                child: GridView.builder(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                itemCount: 10,
                // Generate 100 widgets that display their index in the List.
                itemBuilder:(BuildContext context,int index) {
                  var list = <ProductCard>[];

                  return const ProductCard(name: 'mk17',descprition: 'il primo stadio scubapro è un ottimo erogatore con numero funzionalità',price: 73782);
                }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (screenSize.width-200)~/320,
                    childAspectRatio:320/450

              ),
              )

      ),
]
          )

        )
    );
  }
}




void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
                body:MyApp()
          )
      )

    );
}


*/