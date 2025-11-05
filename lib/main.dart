import 'package:flutter/material.dart';
import 'package:football_news/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'football_news',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // gaya biru seperti tutorial
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueAccent),
        useMaterial3: false, // biar shadow & warna mirip contoh
      ),
      home: MyHomePage(),
    );
  }
}
