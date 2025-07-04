import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(RecipeApp());

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodHub',
      theme: ThemeData(
        // Base colors
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,

        // AppBar styling
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.green),
          titleTextStyle: TextStyle(
            color: Colors.green.shade700,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // BottomNavigationBar styling
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          elevation: 8,
        ),

        // Card styling
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),

        // ElevatedButton styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,    // was `primary`
            foregroundColor: Colors.white,     // was `onPrimary`
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),

        // Input decoration (for your search bar, etc.)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.green.shade50,
          prefixIconColor: Colors.green,
          suffixIconColor: Colors.green,
          hintStyle: TextStyle(color: Colors.grey[600]),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),

        // Text styling
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),

        // IconTheme (default icon color)
        iconTheme: IconThemeData(color: Colors.green.shade700),
      ),
      home: HomeScreen(),
    );
  }
}
