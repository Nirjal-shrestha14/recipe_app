import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'recipe_list_page.dart';
import 'saved_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  @override _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _favoriteRecipes = <Recipe>[];

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      if (_favoriteRecipes.contains(recipe))
        _favoriteRecipes.remove(recipe);
      else
        _favoriteRecipes.add(recipe);
    });
  }

  void _onTabTapped(int idx) => setState(() => _selectedIndex = idx);

  @override
  Widget build(BuildContext ctx) {
    final pages = [
      RecipeListPage(onToggleFavorite: _toggleFavorite, favoriteRecipes: _favoriteRecipes),
      SavedPage(favoriteRecipes: _favoriteRecipes),
      ProfilePage(savedCount: _favoriteRecipes.length, onLogout: () {}),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}
