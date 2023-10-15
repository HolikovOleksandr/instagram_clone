// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    //   return Center(
    //     child: IconButton(
    //       icon: Icon(Icons.upload),
    //       onPressed: () {},
    //     ),
    //   );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mobileBackground,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text('Post to'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Post',
              style: TextStyle(
                color: AppColor.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(AppAssets.avatar),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .3,
                child: TextField(
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(AppAssets.avatar),
                        alignment: FractionalOffset.topCenter,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),          
            ],
          ),
        ],
      ),
    );
  }
}
