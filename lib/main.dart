import 'package:flutter/material.dart';
import 'widgets/top_nav_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        appBar: TopNavBar(),
        body: Center(child: Text('Content Placeholder')), // Replace with your actual page body
      ),
    );
  }
}
