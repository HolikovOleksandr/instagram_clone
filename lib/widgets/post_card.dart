// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: AppColor.mobileBackground,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Padding(
            padding: EdgeInsets.fromLTRB(12, 4, 0, 4),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap['profileImage']),
                ),
                SizedBox(width: 8),
                Text(
                  widget.snap['username'],
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
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
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
          GestureDetector(
            onDoubleTap: () {
              FirestoreMethods().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() => isLikeAnimating = true);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * .35,
                  child:
                      Image.network(widget.snap['postUrl'], fit: BoxFit.cover),
                ),
                AnimatedOpacity(
                  opacity: isLikeAnimating ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 40),
                    child: Icon(Icons.favorite, color: Colors.white, size: 120),
                    onEnd: () async {
                      await FirestoreMethods().likePost(widget.snap['postId'],
                          user.uid, widget.snap['likes']);

                      setState(() => isLikeAnimating = false);
                    },
                  ),
                ),
              ],
            ),
          ),
          // SOCIAL ACTIVE BUTTONS
          Row(
            children: [
              // Like
              LikeAnimation(
                smallLike: true,
                isAnimating: widget.snap['likes'].contains(user.uid),
                child: IconButton(
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                  onPressed: () async {
                    await FirestoreMethods().likePost(
                        widget.snap['postId'], user.uid, widget.snap['likes']);
                  },
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
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.snap['likes'].length} likes',
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
