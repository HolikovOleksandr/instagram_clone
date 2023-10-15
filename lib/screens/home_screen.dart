// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main'), centerTitle: true),
      body: Column(
        children: [
          Center(
            child: Text('Home Screen'),
          ),
        ],
      ),
    );
  }
}
