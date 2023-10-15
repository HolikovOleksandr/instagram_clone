// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:instagram_clone/utils/global_variables.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int page = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() => this.page = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        controller: pageController,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: AppColor.mobileBackground,
        items: [
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(
              Icons.home,
              color: page == 0 ? AppColor.primary : AppColor.secondary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(
              Icons.search,
              color: page == 1 ? AppColor.primary : AppColor.secondary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(
              Icons.add_circle_outline_outlined,
              color: page == 2 ? AppColor.primary : AppColor.secondary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(
              Icons.favorite,
              color: page == 3 ? AppColor.primary : AppColor.secondary,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColor.primary,
            icon: Icon(
              Icons.account_circle_outlined,
              color: page == 4 ? AppColor.primary : AppColor.secondary,
            ),
            label: '',
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
