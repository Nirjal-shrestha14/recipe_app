class Recipe {
  final String id;
  final String title;
  final String imageAsset;
  final int difficulty;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final String category;

  Recipe({
    required this.id,
    required this.title,
    required this.imageAsset,
    required this.difficulty,
    required this.duration,
    required this.ingredients,
    required this.steps,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Recipe &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
