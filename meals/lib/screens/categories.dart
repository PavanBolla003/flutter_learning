import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.onToggleFavourite,
    required this.glutenFree,
    required this.lactoseFree,
    required this.vegetarian,
    required this.vegan,
  });

  final void Function(Meal meal) onToggleFavourite;
  final bool glutenFree;
  final bool lactoseFree;
  final bool vegetarian;
  final bool vegan;

  void _selectCategory(BuildContext context, String id, String title) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(id))
        .where((meal) {
          if (glutenFree && !meal.isGlutenFree) return false;
          if (lactoseFree && !meal.isLactoseFree) return false;
          if (vegetarian && !meal.isVegetarian) return false;
          if (vegan && !meal.isVegan) return false;
          return true;
        })
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: title,
          meals: filteredMeals,
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: (ctx) =>
                  _selectCategory(ctx, category.id, category.title),
            ),
        ],
      ),
    );
  }
}
