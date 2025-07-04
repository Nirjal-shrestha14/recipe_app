import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class SavedPage extends StatelessWidget {
  final List<Recipe> favoriteRecipes;

  SavedPage({required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Recipes',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
      ),
      body: SafeArea(
        child: favoriteRecipes.isEmpty
            ? Center(
          child: Text('No saved recipes yet.',
              style: theme.textTheme.bodyLarge),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: favoriteRecipes.length,
          itemBuilder: (ctx, i) {
            final recipe = favoriteRecipes[i];
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => RecipeDetailScreen(recipe: recipe)),
              ),
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: RecipeCard(
                  recipe: recipe,
                  isFavorite: true,
                  onFavoriteToggle: () {}, // optional in Saved page
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}