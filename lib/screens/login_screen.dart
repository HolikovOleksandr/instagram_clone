// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_build_context_synchronously
import 'package:instagram_clone/responcive/mobile_layout.dart';
import 'package:instagram_clone/responcive/responcive_layout.dart';
import 'package:instagram_clone/responcive/web_layout.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/widgets/auth_button.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() => _isLoading = true);

    String res = await AuthMethods().loginUser(
      email: _email.text,
      password: _password.text,
    );

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobileScreen: MobileScreen(),
            webScreen: WebScreen(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(context, res);
    }
    debugPrint(" ======== ${res.toString()} ========");
    setState(() => _isLoading = false);
  }

  navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupScreen(),
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
              SvgPicture.asset('assets/images/instagram_logo.svg',
                  color: AppColor.primary, height: 64),
              SizedBox(height: 64),
              //
              // Email text input field
              TextFielsInput(
                  keyboardType: TextInputType.emailAddress,
                  textController: _email,
                  hintText: 'Enter your email'),
              SizedBox(height: 24),
              //
              // Password text input field
              TextFielsInput(
                  keyboardType: TextInputType.text,
                  textController: _password,
                  hintText: 'Enter your password',
                  isPassword: true),
              SizedBox(height: 24),
              //
              // Login user button
              AuthButton(
                onTap: () => loginUser(),
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
                    child: Text('Don\'t have an account?'),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => navigateToSignUp(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Sign up',
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
