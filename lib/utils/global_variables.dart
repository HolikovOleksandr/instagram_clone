import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = <Widget>[
  FeedScreen(),
  Center(child: Text('Search')),
  AddPostScreen(),
  Center(child: Text('Favoriete')),
  Center(child: Text('Account')),
];
