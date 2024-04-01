import "package:flutter/material.dart";
import "package:meals/data/dummy_data.dart";
import "package:meals/models/category.dart";
import "package:meals/models/meal.dart";
import "package:meals/screens/meals.dart";
import "package:meals/widgets/category_grid_item.dart";

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // storing animation property
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // configuring the animation with the initState() method
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    // starting the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // method for selecting the meal categories
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,

      // fitting in only the contents that should be part of the animation into the separate child
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // outputting all available meal categories
          for (final category
              in availableCategories) // the for in loop is an alternative method for the map()
            CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                })
        ],
      ),

      // controlling what should be animated
      builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut),
          ),
          child: child),
    );
  }
}
