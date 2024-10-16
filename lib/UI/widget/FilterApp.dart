import 'dart:convert';
import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/object/Brand.dart';
import '../../model/object/Categoria.dart';
import '../../model/support/MyConstant.dart';


class Filter extends StatefulWidget {
  String categoria;
  final Function(Map<String, bool>) onApplyFilters; // Aggiungi un callback
  Filter(this.categoria, {required this.onApplyFilters});

  @override
  _FilterState createState() => _FilterState(categoria);
}

class _FilterState extends State<Filter> {
  bool _searching = true;
  String categoria;
  Map<String, bool> _filterBrand = {};

  _FilterState(this.categoria);

  @override
  void initState() {
    super.initState();
    _search(); // Spostato in initState per evitare chiamate multiple
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      ElevatedButton(
        child: const Text(
          "Applica filtri",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.deepPurple),
        ),
        onPressed: () {
          widget.onApplyFilters(_filterBrand); // Richiama il callback
        },
      ),
      SizedBox(height: 20),
      Container(
        width: MyConstant.wfmax - 40,
        decoration: BoxDecoration(
          color: Color(0xD2E8E8F3),
          borderRadius: BorderRadius.circular(MyConstant.bAm),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text("Brand",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xFF5E2A9B))),
          SizedBox(height: 10),
          !_searching
              ? _filterBrand.length == 0
              ? noResults()
              : SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _filterBrand.keys.map((String key) {
                return ChoiceChip(
                  elevation: 6,
                  pressElevation: 8,
                  label: Text(
                    key,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.deepPurple),
                  ),
                  selected: _filterBrand[key]!,
                  backgroundColor: const Color(0x919191C5),
                  selectedColor: Colors.white,
                  checkmarkColor: Colors.deepPurple,
                  onSelected: (bool selected) {
                    setState(() {
                      _filterBrand[key] = selected;
                    });
                  },
                );
              }).toList(),
            ),
          )
              : CircularProgressIndicator(),
        ]),
      ),
      SizedBox(height: 20),
    ]);
  }

  Widget noResults() {
    return Text("no_results !");
  }

  void _search() {
    if (_searching) {
      Model.sharedInstance.getBrandCategory(categoria)!.then((brands) {
        setState(() {
          _searching = false;
          _filterBrand.clear();
          for (Brand b in brands!) {
            _filterBrand.putIfAbsent(b.name, () => false);
          }
        });
      }).catchError((error) {
        // Gestisci l'errore
        setState(() {
          _searching = false;
        });
        print("Errore durante la ricerca dei brand: $error");
      });
    }
  }
}
