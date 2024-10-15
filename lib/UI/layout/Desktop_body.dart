import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Provider/LogProvider.dart';
import 'package:store/UI/pages/CatScarpe.dart';
import 'package:store/UI/pages/LoginPage.dart';
import 'package:store/model/SharedPreferenceManager.dart';

import '../../model/Model.dart';
import 'Drawer_cart.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  _MyDesktopBodyState createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
  @override
  Widget build(BuildContext context) {

    var dim = MediaQuery.of(context).size.width * 0.35;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer: SizedBox(width: dim > 450 ? dim : 450, child: DrawerCart()),
        body: Column(
          children: [

    AppBar(
              backgroundColor: Colors.white,
              title: const Text('F A K E _ S T O R E'),

              actions: [
                Consumer<LogProvider>(
    builder: (context, log, child) {
              return  IconButton(
                  icon:   log.log ? const Icon(Icons.lock) : const Icon(Icons.person),
                  onPressed: () async {
                    if (log.log) {
                      if (await Model.sharedInstance.logOut()) {
                        log.LogOut();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('LogOut'),
                                content: Text('LogOut effettuato'),
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
                        });
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginpage()),
                      );
                    }
                  },
                );}),
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      // Apre il Drawer quando si preme l'icona
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
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
                  CatScarpe(categoria: "Mocassini"),
                  CatScarpe(categoria: "Sneakers"),
                  CatScarpe(categoria: "Stivali"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
