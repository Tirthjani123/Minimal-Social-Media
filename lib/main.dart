import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_basics/auth/auth.dart';
import 'package:flutter_firebase_basics/firebase_options.dart';
import 'package:flutter_firebase_basics/pages/home.dart';
import 'package:flutter_firebase_basics/pages/login.dart';
import 'package:flutter_firebase_basics/pages/profile_page.dart';
import 'package:flutter_firebase_basics/pages/user_page.dart';
import 'package:flutter_firebase_basics/theme/dark_mode.dart';
import 'package:flutter_firebase_basics/theme/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: AuthPage(),
      routes: {
        '/login_page': (context)=>LoginPage(),
        '/home_page': (context)=>HomePage(),
        '/profile_page': (context)=>ProfilePage(),
        '/user_page': (context)=>UserPage(),

      },
    );
  }
}