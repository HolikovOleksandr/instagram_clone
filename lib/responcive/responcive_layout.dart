// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:instagram_clone/responcive/mobile_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScreen, webScreen;

  const ResponsiveLayout({
    required this.mobileScreen,
    required this.webScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < webScreenSize ? mobileScreen : webScreen;
      },
    );
  }
}
