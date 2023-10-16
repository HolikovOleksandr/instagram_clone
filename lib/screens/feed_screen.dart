// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:instagram_clone/widgets/post_card.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mobileBackground,
        centerTitle: false,
        title: SvgPicture.asset(
          AppAssets.logo,
          color: AppColor.primary,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: PostCard(),
    );
  }
}
