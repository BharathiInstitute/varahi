import 'package:flutter/material.dart';
import 'widgets/featured_products_section.dart';
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
      home: Scaffold(
        appBar: const TopNavBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FeaturedProductsSection(),
                SizedBox(height: 28),
                BrassCopperItemsSection(),
                SizedBox(height: 28),
                DailyPoojaNeedsSection(),
                // SizedBox(height: 28),
                // FestivalNeedsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
