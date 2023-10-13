// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              //
              // Instagram logotype
              SvgPicture.asset(AppAssets.logo,
                  color: AppColor.primary, height: 64),
              SizedBox(height: 64),
              //
              // User avatar picker
              Stack(
                children: [
                  CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(AppAssets.defaultAvatar)),
                  Positioned(
                      bottom: -10,
                      left: 85,
                      child: IconButton(
                          onPressed: null,
                          icon: Icon(Icons.add_a_photo, color: AppColor.blue))),
                ],
              ),
              SizedBox(height: 24),
              //
              // Username text input field
              TextFielsInput(
                  keyboardType: TextInputType.text,
                  textController: _usernameController,
                  hintText: 'Enter your username'),
              SizedBox(height: 24),
              //
              // Bio text input field
              TextFielsInput(
                  keyboardType: TextInputType.text,
                  textController: _bioController,
                  hintText: 'Enter your bio'),
              SizedBox(height: 24),
              //
              // Email text input field
              TextFielsInput(
                  keyboardType: TextInputType.emailAddress,
                  textController: _emailController,
                  hintText: 'Enter your email'),
              SizedBox(height: 24),
              //
              // Password text input field
              TextFielsInput(
                  keyboardType: TextInputType.text,
                  textController: _passwordController,
                  hintText: 'Enter your password',
                  isPassword: true),
              SizedBox(height: 24),
              //
              // Create new user button
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    color: AppColor.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                  ),
                  child: Text('Log in'),
                ),
              ),
              SizedBox(height: 12),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Already have an account?'),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: null,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Log in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
