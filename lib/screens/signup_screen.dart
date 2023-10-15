// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:instagram_clone/responcive/responcive_layout.dart';
import 'package:instagram_clone/responcive/mobile_layout.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responcive/web_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/widgets/auth_button.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:typed_data';

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
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() => _isLoading = true);

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      userName: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobileScreen: MobileScreen(),
            webScreen: WebScreen(),
          ),
        ),
      );
    }
    debugPrint(" ======== ${res.toString()} ========");
    setState(() => _isLoading = false);
  }

  navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
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
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(AppAssets.avatar)),
                  Positioned(
                      bottom: -10,
                      left: 85,
                      child: IconButton(
                          onPressed: () => selectImage(),
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
              AuthButton(
                onTap: () => signUpUser(),
                isLoading: _isLoading,
                text: 'Sign up',
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
                    onTap: () => navigateToLogin(),
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
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
