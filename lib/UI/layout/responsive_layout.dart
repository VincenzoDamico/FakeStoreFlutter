import 'package:flutter/material.dart';
import 'package:store/model/support/constant.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktop_body;

  ResponsiveLayout({required this.mobileBody, required this.desktop_body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < Constants.mobileWidth) {
          return mobileBody;
        } else {
          return desktop_body;
        }
      },
    );
  }
}