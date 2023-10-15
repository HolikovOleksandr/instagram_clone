import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreen, webScreen;

  const ResponsiveLayout({
    required this.mobileScreen,
    required this.webScreen,
    super.key,
  });

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < webScreenSize
            ? widget.mobileScreen
            : widget.webScreen;
      },
    );
  }
}
