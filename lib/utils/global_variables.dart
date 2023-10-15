import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

const homeScreenItems = <Widget>[
  Center(child: Text('Home')),
  Center(child: Text('Search')),
  AddPostScreen(),
  Center(child: Text('Favoriete')),
  Center(child: Text('Account')),
];
