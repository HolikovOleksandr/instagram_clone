import 'package:instagram_clone/responcive/responcive_layout.dart';
import 'package:instagram_clone/responcive/mobile_layout.dart';
import 'package:instagram_clone/responcive/web_layout.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: AppColor.mobileBackground),
      title: 'Instagram Clone',
      home: const ResponsiveLayout(
        mobileScreen: MobileScreen(),
        webScreen: WebScreen(),
      ),
    );
  }
}
