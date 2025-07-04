import 'package:flutter/material.dart';
import '../data/recipes.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

class RecipeListPage extends StatefulWidget {
  final List<Recipe> favoriteRecipes;
  final Function(Recipe) onToggleFavorite;

  RecipeListPage({
    required this.favoriteRecipes,
    required this.onToggleFavorite,
  });

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  late TextEditingController _searchController;
  String _searchQuery = '';
  final categories = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Appetizer', 'Drinks'];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Recipe> get _filteredRecipes {
    return dummyRecipes.where((r) {
      final matchesSearch = r.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || r.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final popular = dummyRecipes.take(5).toList();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search & Header
              Text("What would you like to cook?", style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search recipes',
                  prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                ),
              ),
              const SizedBox(height: 24),
              // Popular Section
              Text("Most Popular", style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popular.length,
                  itemBuilder: (_, i) {
                    final recipe = popular[i];
                    final fav = widget.favoriteRecipes.contains(recipe);
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
                      ),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(right: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: SizedBox(
                          width: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  recipe.imageAsset,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(recipe.title,
                                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: List.generate(5, (j) {
                                        return Icon(
                                          j < recipe.difficulty ? Icons.star : Icons.star_border,
                                          size: 14,
                                          color: Colors.amber,
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 4),
                                    Text("${recipe.duration} min",
                                        style: theme.textTheme.bodySmall?.copyWith(
                                            fontStyle: FontStyle.italic, color: Colors.grey[700])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Category Filters
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final cat = categories[i];
                    final selected = cat == _selectedCategory;
                    return ChoiceChip(
                      label: Text(cat,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: selected ? Colors.white : Colors.black87)),
                      selected: selected,
                      selectedColor: Colors.green,
                      backgroundColor: Colors.grey.shade200,
                      onSelected: (_) => setState(() => _selectedCategory = cat),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Filtered List
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _filteredRecipes.length,
                itemBuilder: (ctx, i) {
                  final recipe = _filteredRecipes[i];
                  final fav = widget.favoriteRecipes.contains(recipe);
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: RecipeCard(
                      recipe: recipe,
                      isFavorite: fav,
                      onFavoriteToggle: () {
                        widget.onToggleFavorite(recipe);
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}