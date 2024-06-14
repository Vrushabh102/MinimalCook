import 'package:flutter/material.dart';
import 'package:food_suggester/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true).copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color.fromARGB(255, 236, 234, 234),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
