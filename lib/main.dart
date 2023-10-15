import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responcive/responcive_layout.dart';
import 'package:instagram_clone/responcive/mobile_layout.dart';
import 'package:instagram_clone/responcive/web_layout.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: AppColor.mobileBackground),
        title: 'Instagram Clone',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    mobileScreen: MobileScreen(), webScreen: WebScreen());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.primary),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
