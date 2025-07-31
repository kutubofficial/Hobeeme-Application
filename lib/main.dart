import 'package:flutter/material.dart';
import 'package:task_two/auth/loginpage.dart';
// import 'map_page/map_page.dart' as map_page;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF-Pro-Display',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      ),
      // home: const SearchScreen(),
      home: const LoginPage(),
    );
  }
}
