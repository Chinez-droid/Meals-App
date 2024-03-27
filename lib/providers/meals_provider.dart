import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meals/data/dummy_data.dart";

// storing our provider object
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
