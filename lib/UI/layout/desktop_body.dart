import 'package:flutter/material.dart';
import 'package:store/UI/pages/catScarpe.dart';
import 'package:store/model/support/constant.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  _MyDesktopBodyState createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              title: const Text('D E S K T O P'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    // Handle account icon tap
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: (

                      ) {
                    // Handle shopping cart icon tap
                  },
                ),
              ],
            ),
            Container(
              color: Colors.white, // Background color for TabBar
              child: SafeArea(
                child: TabBar(
                  tabs: [
                    Tab(text: 'M o c a s s i n i'),
                    Tab(text: 'S n e a k e r s'),
                    Tab(text: 'S t i v a l i')
                  ],
                ),
              ),
            ),
            // AppBar below the tabs

            // TabBarView for content
            Expanded(
              child: TabBarView(
                children: [

                  catScarpe("Mocassini"),
                  catScarpe("Sneakers"),
                  catScarpe("Stivali")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

