import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
    }
  }

  void _setGlutenFree(bool value) {
    setState(() {
      _glutenFree = value;
    });
  }

  void _setLactoseFree(bool value) {
    setState(() {
      _lactoseFree = value;
    });
  }

  void _setVegetarian(bool value) {
    setState(() {
      _vegetarian = value;
    });
  }

  void _setVegan(bool value) {
    setState(() {
      _vegan = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      glutenFree: _glutenFree,
      lactoseFree: _lactoseFree,
      vegetarian: _vegetarian,
      vegan: _vegan,
    );
    var activePageTitle = 'Meals';

    if (_selectedPageIndex == 1) {
      activePage = FiltersScreen(
        glutenFree: _glutenFree,
        lactoseFree: _lactoseFree,
        vegetarian: _vegetarian,
        vegan: _vegan,
        onGlutenFreeChanged: _setGlutenFree,
        onLactoseFreeChanged: _setLactoseFree,
        onVegetarianChanged: _setVegetarian,
        onVeganChanged: _setVegan,
      );
      activePageTitle = 'Filters';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Meals App',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Meals'),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: const Text('Filters'),
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
