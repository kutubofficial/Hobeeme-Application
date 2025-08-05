import 'package:Hobeeme/Experience/events_page.dart';
import 'package:flutter/material.dart';
// import 'package:Hobeeme/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hobeeme App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF-Pro-Display',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      ),
      // home: const HomePage(),
      home: const EventsPage(),
    );
  }
}
