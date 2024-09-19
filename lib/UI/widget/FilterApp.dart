import 'package:flutter/material.dart';

import '../../model/support/MyConstant.dart';

/// Flutter code sample for [Radio].

class FilterApp extends StatelessWidget {
  const FilterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Filter();
  }
}

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  Map<String, bool> _filterBrand = {
    'isAvailable': false,
    'isSelected': false,
    'isEnabled': false,
    'isVisible': false,
  };
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      Container(
          width: MyConstant.wfmax-40,

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
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8.0, // Spazio tra i chip
                runSpacing: 8.0, // Spazio tra le righe dei chip
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
                    backgroundColor: const Color(
                        0x919191C5), // Colore sfondo non selezionato
                    selectedColor: Colors.white, // Colore sfondo selezionato
                    checkmarkColor: Colors.deepPurple,
                    onSelected: (bool selected) {
                      setState(() {
                        _filterBrand[key] = selected; // Aggiorna la mappa
                      });
                    },
                  );
                }).toList(),
              ),
            )
          ]))
    ]);
  }
}
