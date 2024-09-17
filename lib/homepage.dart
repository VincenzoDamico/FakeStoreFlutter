import 'package:flutter/material.dart';
import 'package:store/UI/layout/desktop_body.dart';
import 'package:store/UI/layout/mobile_body.dart';
import 'package:store/UI//layout/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MyMobileBody(),
        desktop_body: MyDesktopBody(),
      ),
    );
  }
}