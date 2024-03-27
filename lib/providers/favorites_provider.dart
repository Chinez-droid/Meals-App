import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

// the advanced riverpod state class
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // constructor function initialized to the parent class data
  FavoriteMealsNotifier() : super([]);

  // method to edit the data
  void toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

// default property for storing data to provider
final favoritesMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
