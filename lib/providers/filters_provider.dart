import 'package:flutter_riverpod/flutter_riverpod.dart';

// unique identifiers for configuring the filters
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

// class for configuring the filtersScreen with riverpod's provider
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  // riverpod's constructor function
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  // method to manipulate the defined state
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

// storing the filters provider property to our parent class
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());
