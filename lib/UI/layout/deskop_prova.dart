/*import 'package:flutter/material.dart';
import 'package:store/UI/widget/ProductCard.dart';

import '../../model/Model.dart';
import '../../model/object/Product.dart';
import '../../model/support/constant.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<MyDesktopBody> {
  bool _isLoading = true;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final products = await Model.sharedInstance.getAllProduct() ?? [];
      setState(() {
        _isLoading = false;
        _products = products;
      });
    } catch (error) {
      // Handle error
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _products.isEmpty
          ? Center(child: Text('No products found'))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust the number of columns as needed
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductCard(prod: _products[index]);
        },
      ),
    );
  }
}*/