import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  // configuring the variable for selecting the page index
  int _selectedPageIndex = 0;

  // storing list of meals in the tabsScreenState
  final List<Meal> _favoriteMeals = [];

  // method to display an info when meals are added for favorites screen
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // function to manage the list of meals(adding/removing it from favorites)
  void _toogleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    // remove meal from the favorites if it exist, add if it doesn't
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      });
    }
  }

  // managed method for selecting between navigation bars
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // storing the categoriesScreen as activePage for navigation
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toogleMealFavoriteStatus,
    );
    // storing the appBar title as a variable
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toogleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    // returning the design & functionality of the widget
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
