import 'package:flutter/material.dart';
import 'package:newsapp/BottomNav.dart';
import 'package:newsapp/Theme/dark.dart';
import 'package:newsapp/Theme/light..dart';
import 'package:newsapp/category.dart';
// import 'package:newsapp/category.dart';
import 'package:newsapp/login&regsiter/Register.dart';
import 'package:newsapp/login&regsiter/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyRegisterPage(),
      darkTheme: darktheme,
      theme: lighttheme,
      initialRoute: 'login/',
      routes: {
        'category/': (context) => const Category(),
        'home/': (context) => const BottomNav(),
        'login/': (context) => const LoginPage(),
        'register/': (context) => const MyRegisterPage()
      },
    );
  }
}
