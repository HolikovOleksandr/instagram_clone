// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.mobileBackground,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 0, 4),
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(AppAssets.avatar)),
                SizedBox(width: 8),
                Text(
                  'user_name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: ['Delete']
                                .map(
                                  (e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          // IMAGE
          SizedBox(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * .35,
            child: Image.network(AppAssets.avatar, fit: BoxFit.cover),
          ),
          // SOCIAL ACTIVE BUTTONS
          Row(
            children: [
              // Like
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              // Comment
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
                  color: AppColor.primary,
                  size: 30,
                ),
              ),
              // Share
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send_rounded,
                  size: 30,
                  color: AppColor.primary,
                ),
              ),
              Spacer(),
              // Save
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                  color: AppColor.primary,
                  size: 30,
                ),
              ),
            ],
          ),
          // All likes count
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1234 likes',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'user_name:',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Hey this soo long desctiption text for awesome post will be replaced with data base description in future',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'View all 1997 comments',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '2 days ago',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColor.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
